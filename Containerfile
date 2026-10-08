# GRUB2 review-runner image. Variants via --target: standalone (A) / baked (B) / full (C).
# Build context MUST be $HOME (COPY reads host ~/.claude + this repo). Docs: README-container.md.

# --- base: OS + Node + Claude Code + user -----------------------------------------------------
ARG BASE=fedora
FROM ${BASE} AS base
ARG APP_USER=claudeuser
ARG APP_UID=1000
ARG WORKDIR=/grub-devel
ARG CLAUDE_PKG=@anthropic-ai/claude-code
RUN dnf install -y nodejs npm git ca-certificates && dnf clean all
RUN npm install -g ${CLAUDE_PKG} && npm cache clean --force
RUN useradd -m -u ${APP_UID} -s /bin/bash ${APP_USER} \
 && mkdir -p ${WORKDIR} && chown ${APP_USER}:${APP_USER} ${WORKDIR}
WORKDIR ${WORKDIR}
ENV MODEL=claude-sonnet-5

# --- config: host Claude config + skills (skip skills/plugins .git and skills CLAUDE.md) -------
# Copies the host's ~/.claude CONFIG so the container behaves like the host: skills, plugins,
# global settings.json + CLAUDE.md — all at the same $HOME-relative path, so
# ~/.claude/skills/review-toolbox/rtb (the read-only review wrapper reviews rely on) resolves
# identically here. review-toolbox is REQUIRED; executable bits are preserved by COPY.
# DELIBERATELY NOT copied (private / huge / not shareable — variant A must stay shareable):
# projects/ (session transcripts, 100M+), history.jsonl, sessions/, file-history/, cache/,
# shell-snapshots/, backups/, debug/, stats-cache.json, and any credentials.
FROM base AS config
ARG APP_USER=claudeuser
ARG CLAUDE_SRC=.claude
ARG CLAUDE_HOME=/home/claudeuser/.claude
COPY --chown=${APP_USER}:${APP_USER} ${CLAUDE_SRC}/skills/ ${CLAUDE_HOME}/skills/
COPY --chown=${APP_USER}:${APP_USER} ${CLAUDE_SRC}/plugins/ ${CLAUDE_HOME}/plugins/
COPY --chown=${APP_USER}:${APP_USER} ${CLAUDE_SRC}/settings.json ${CLAUDE_SRC}/CLAUDE.md ${CLAUDE_HOME}/
RUN find ${CLAUDE_HOME}/skills ${CLAUDE_HOME}/plugins -type d -name .git -prune -exec rm -rf {} + \
 && rm -f ${CLAUDE_HOME}/skills/CLAUDE.md

# --- reviewer: static reviewer knowledge/tooling, baked into every variant ---------------------
FROM config AS reviewer
ARG APP_USER=claudeuser
ARG WORKDIR=/grub-devel
# Path to this repo, relative to the build context ($HOME). Override with --build-arg.
ARG REPO_SRC=lpcsf-new/test/rhel/packages/grub2/grub-devel
COPY --chown=${APP_USER}:${APP_USER} \
     ${REPO_SRC}/CLAUDE.md ${REPO_SRC}/HANDOVER.md ${REPO_SRC}/MEMORY.md \
     ${REPO_SRC}/DUMP_MEMORY.md ${REPO_SRC}/MRS_BY_AUTHOR.md \
     ${REPO_SRC}/README.md ${REPO_SRC}/.rtbrc ${REPO_SRC}/FACTS.md ${WORKDIR}/
COPY --chown=${APP_USER}:${APP_USER} ${REPO_SRC}/docs/ ${WORKDIR}/docs/
COPY --chown=${APP_USER}:${APP_USER} ${REPO_SRC}/templates/ ${WORKDIR}/templates/
COPY --chown=${APP_USER}:${APP_USER} ${REPO_SRC}/helpers/ ${WORKDIR}/helpers/
COPY ${REPO_SRC}/container/container-review-prompt.txt /usr/local/share/review-prompt.txt
COPY ${REPO_SRC}/container/container-entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# --- standalone (A): shareable; no creds/provider baked; data mounted at runtime --------------
FROM reviewer AS standalone
ARG APP_USER=claudeuser
ARG WORKDIR=/grub-devel
RUN mkdir -p ${WORKDIR}/grub ${WORKDIR}/reviews ${WORKDIR}/data \
 && echo standalone > ${WORKDIR}/variant \
 && chown -R ${APP_USER}:${APP_USER} ${WORKDIR}
USER ${APP_USER}
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# --- baked (B): this host's Vertex config baked; data mounted at runtime (not shareable) -------
FROM reviewer AS baked
ARG APP_USER=claudeuser
ARG WORKDIR=/grub-devel
ARG USE_VERTEX=1
ARG VERTEX_PROJECT_ID=itpc-ca-eb9acc3805
ARG CLOUD_ML_REGION=global
ENV CLAUDE_CODE_USE_VERTEX=${USE_VERTEX} \
    ANTHROPIC_VERTEX_PROJECT_ID=${VERTEX_PROJECT_ID} \
    CLOUD_ML_REGION=${CLOUD_ML_REGION}
RUN mkdir -p ${WORKDIR}/grub ${WORKDIR}/reviews ${WORKDIR}/data \
 && echo baked > ${WORKDIR}/variant \
 && chown -R ${APP_USER}:${APP_USER} ${WORKDIR}
USER ${APP_USER}
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# --- full (C): everything baked (whole repo), no mounts needed (not shareable) -----------------
FROM baked AS full
ARG APP_USER=claudeuser
ARG WORKDIR=/grub-devel
ARG REPO_SRC=lpcsf-new/test/rhel/packages/grub2/grub-devel
USER root
COPY --chown=${APP_USER}:${APP_USER} ${REPO_SRC}/ ${WORKDIR}/
RUN echo full > ${WORKDIR}/variant \
 && chown -R ${APP_USER}:${APP_USER} ${WORKDIR}
USER ${APP_USER}
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
