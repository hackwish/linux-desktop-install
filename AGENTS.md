# AGENTS.md

## What this repo is

Shell scripts + Ansible playbooks for provisioning Linux/Mac desktops, devops workstations, TV/HTPC, and servers. Not an application -- it's an infrastructure provisioning tool.

## Entry points

- `install.sh` — auto-detects OS (`uname`), sources `install_linux.sh` or `install_mac.sh`
- `install_linux.sh` — must run as root. Installs deps, maps distro codenames, installs Ansible, fetches Galaxy roles, then presents a menu to pick a playbook
- `install_mac.sh` — installs Homebrew, asdf, oh-my-zsh, Ansible, then presents a menu
- `install.sh.old` — legacy, do not modify

## Playbook hierarchy

Playbooks import each other in a chain:

**Linux:** `devops.yml` → `desktop.yml` → `common.yml`
**Mac:** `mac-devops.yml` → `mac-desktop.yml` → `mac-common.yml`

Each level adds more roles on top of its parent. Scenarios: `base` (common only), `desktop`, `devops`, `tv`, `server`.

## Roles live in external repos

`ansible/roles/` is **gitignored** and always empty. All roles are fetched at runtime via `ansible-galaxy` from:
- `ansible/requirements.yml` — Linux roles + collections
- `ansible/requirements_mac.yml` — Mac roles + collections

All role repos are under the `hackwish` GitHub org (e.g. `hackwish/ansible-common.git`). To add a new role: create its repo there, add it to the appropriate requirements file, then reference it in the relevant playbook(s).

## Distro codename mapping

`install_linux.sh` maps non-Ubuntu distro codenames to Ubuntu equivalents (e.g. Mint `wilma`/`xia`/`zara` → `noble`, Mint `vanessa`/`vera`/`victoria`/`virginia` → `jammy`, Elementary `odin` → `focal`). When adding support for a new distro release, update both the codename-to-PPA mapping (lines ~25-39) and the codename-to-Ubuntu mapping (lines ~74-96) in `install_linux.sh`.

## Releases

- Semantic-release via `.releaserc.yml`, triggered by CI on push to `master`/`main`
- `CHANGELOG.md` is auto-generated and **gitignored** — do not manually edit
- Commit convention: [Conventional Commits](https://www.conventionalcommits.org/). Scopes used: `linux`, `mac`, `ansible`, `install`, `install-linux`, `install-mac`, `desktop`, `package`, `repo`, `tasks`
- CI workflow: `.github/workflows/actions.yml`

## Things to watch out for

- Scripts use Spanish for user-facing messages (echo/PS3 prompts) — keep this consistent
- `install_linux.sh` requires `sudo` — it checks `id -u` and exits if not root
- The `ansible/hosts` inventory always targets `127.0.0.1` with `ansible_connection=local` (localhost provisioning)
- Ansible verbosity varies by scenario: `-vv` for most, `-vvv` for devops
- Several stale `sync-conflict-*` branches exist from Syncthing — ignore them
- `output.yaml` and `text_files/` are legacy/reference material, not active
