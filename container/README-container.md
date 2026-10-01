# Containerized GRUB2 review runner

Build and run Claude Code as a self-contained GRUB2 merge-request reviewer. One `Containerfile`
provides three build targets (variants). You do not need to read the `Containerfile` — everything
you need is here.

## TL;DR

```bash
# A (shareable):  podman build -f Containerfile --target standalone -t grub-review:a "$HOME"
# B (this host):  podman build -f Containerfile --target baked      -t grub-review:b "$HOME"
# C (all baked):  podman build -f Containerfile --target full       -t grub-review:c "$HOME"
```

> **Build context is `$HOME`** (the trailing `"$HOME"` above). `COPY` can only read files under
> the build context, and the host Claude config lives at `~/.claude`. The default assumes this
> repo sits at `~/lpcsf-new/test/rhel/packages/grub2/grub-devel`; if it lives elsewhere, pass
> `--build-arg REPO_SRC=<path-relative-to-$HOME>`.

## The three variants

| Variant | Target | Claude config + skills | Reviewer docs/tooling | Host Vertex config | Review data (`grub/`, `reviews/`, `new.txt`) | Shareable |
|---------|--------|:---:|:---:|:---:|:---:|:---:|
| **A** | `standalone` | baked | baked | — (supply at runtime) | mounted | yes |
| **B** | `baked` | baked | baked | baked | mounted | no |
| **C** | `full` | baked | baked | baked | **baked** (whole repo) | no |

- **Reviewer docs/tooling** (baked into every variant, because they are reviewer configuration,
  not per-batch data): `CLAUDE.md`, `HANDOVER.md`, `MEMORY.md`, `DUMP_MEMORY.md`,
  `MEMORY_DUMP_2.txt`, `MRS_BY_AUTHOR.md`, `README.md`, `docs/`, `templates/`, `helpers/`.
- **Claude config**: `~/.claude/settings.json` and all of `~/.claude/skills/*/` (the skills' own
  `.git` and `skills/CLAUDE.md` are dropped). Nothing else is taken from `$HOME`.
- Each image writes `/grub-devel/variant` containing `standalone` / `baked` / `full` so you can
  tell what a running container was built as: `podman run --rm grub-review:b cat variant`.
- **In-container working directory is `/grub-devel`** (named to match the host repo). Inside it:
  `grub/`, `reviews/`, `data/new.txt` — three distinct locations (`grub/` and `reviews/` are
  siblings, not nested).

## Credentials & provider (Vertex)

This setup uses the **Claude Vertex AI** backend. The relevant settings:

- `CLAUDE_CODE_USE_VERTEX=1`
- `ANTHROPIC_VERTEX_PROJECT_ID=itpc-ca-eb9acc3805`
- `CLOUD_ML_REGION=global`

Variants **B** and **C** bake these in (that is what makes them host-specific / non-shareable);
override at build with `--build-arg VERTEX_PROJECT_ID=... --build-arg CLOUD_ML_REGION=...`, or set
`--build-arg USE_VERTEX=` to leave the provider unset. Variant **A** bakes none of it — pass it at
runtime with `-e`.

GCP **credentials** are user-specific and are **not** baked into any variant — supply them at
runtime (this part is WIP/PoC; assume it is wired up later), e.g. mount an Application Default
Credentials / service-account file and point `GOOGLE_APPLICATION_CREDENTIALS` at it:

```bash
-v "$HOME/.config/gcloud:/home/claudeuser/.config/gcloud:ro,Z"
# or:  -v /path/to/sa.json:/run/gcp.json:ro,Z  -e GOOGLE_APPLICATION_CREDENTIALS=/run/gcp.json
```

## Running

Default entrypoint: an **interactive** `claude` seeded with the batch-review prompt (needs
`-it`). Pass a command to override (e.g. `bash`). `--dangerously-skip-permissions` is **off by
default**; enable it with `-e CLAUDE_SKIP_PERMISSIONS=1`.

### A — standalone

Supply provider/creds and mount the three data locations:

```bash
podman run --rm -it \
  -e CLAUDE_CODE_USE_VERTEX=1 \
  -e ANTHROPIC_VERTEX_PROJECT_ID=itpc-ca-eb9acc3805 -e CLOUD_ML_REGION=global \
  -v "$HOME/.config/gcloud:/home/claudeuser/.config/gcloud:ro,Z" \
  -v "$PWD/grub:/grub-devel/grub:ro,Z" \
  -v "$PWD/reviews:/grub-devel/reviews:Z" \
  -v "$PWD/data/new.txt:/grub-devel/data/new.txt:ro,Z" \
  grub-review:a
```

### B — baked

Provider is baked; mount only creds + the three data locations:

```bash
podman run --rm -it \
  -v "$HOME/.config/gcloud:/home/claudeuser/.config/gcloud:ro,Z" \
  -v "$PWD/grub:/grub-devel/grub:ro,Z" \
  -v "$PWD/reviews:/grub-devel/reviews:Z" \
  -v "$PWD/data/new.txt:/grub-devel/data/new.txt:ro,Z" \
  grub-review:b
```

### C — full (one-go, nothing mounted)

The whole repo is baked in, so no data mounts are needed (only creds). Good for testing the
workflow end-to-end. For a non-interactive single run:

```bash
podman run --rm \
  -e CLAUDE_SKIP_PERMISSIONS=1 \
  -v "$HOME/.config/gcloud:/home/claudeuser/.config/gcloud:ro,Z" \
  grub-review:c \
  claude -p "$(cat /usr/local/share/review-prompt.txt)" --dangerously-skip-permissions --model sonnet
```

Edit a batch before building C by changing `data/new.txt` in the repo first. `reviews/` is written
inside the container; copy results out with `podman cp` if you want them on the host.

## Common build-arg overrides

| Arg | Default | Purpose |
|-----|---------|---------|
| `BASE` | `fedora` | Base image |
| `MODEL` | `claude-sonnet-5` | Model Claude Code runs as (also overridable at runtime with `-e MODEL=`) |
| `REPO_SRC` | `lpcsf-new/test/rhel/packages/grub2/grub-devel` | This repo's path relative to `$HOME` |
| `CLAUDE_SRC` | `.claude` | Host Claude config path relative to `$HOME` |
| `WORKDIR` | `/grub-devel` | In-container working directory |
| `APP_USER` / `APP_UID` | `claudeuser` / `1000` | In-container user |
| `VERTEX_PROJECT_ID` / `CLOUD_ML_REGION` / `USE_VERTEX` | host values / `1` | Vertex config (B/C) |

`MODEL` defaults to `claude-sonnet-5`; if your Vertex setup needs a different id or the plain
`sonnet` alias, override it (`--build-arg MODEL=sonnet` or `-e MODEL=...`).

## About `.containerignore`

A `.containerignore` (podman's equivalent of `.dockerignore`) is a file of glob patterns listing
paths to **exclude from the build context** before the build starts — so excluded files are never
sent to the builder and never match a `COPY`. It is used to keep images small/clean and to avoid
copying junk or secrets (e.g. `.git`, `node_modules`, caches).

This project does **not** ship one, on purpose: the build context is `$HOME`, so a
`$HOME/.containerignore` would affect your whole home directory and anything else you build from
there. Instead the few unwanted paths (the skills' `.git`, `skills/CLAUDE.md`) are removed inside
the image. If you prefer context-level exclusion without touching `$HOME`, point podman at a
dedicated ignore file: `podman build --ignorefile /path/to/myignore ...`.

> **Note:** variants **B** and **C** bake host configuration/provider settings (and C bakes the
> whole repo). Treat those images as private — handling of pushing/sharing/commits is entirely
> up to you; nothing here pushes or commits anything.
