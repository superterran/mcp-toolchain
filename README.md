# MCP Toolchain

Dockerized [Model Context Protocol](https://modelcontextprotocol.io/) server toolchain with pack-based images for different technology stacks. Pull a single image per stack and get all the MCP servers, runtimes, and dependencies bundled together.

## Images

| Image | Tag | Contents |
|-------|-----|----------|
| Base | `ghcr.io/superterran/mcp-toolchain:base` | Node.js 22, Python 3, uv, entrypoint router |
| Local | `ghcr.io/superterran/mcp-toolchain:local` | Base + Playwright MCP, filesystem MCP |
| Commerce | `ghcr.io/superterran/mcp-toolchain:commerce` | Base + PHP 8.2, Composer, PHPStan, Adobe I/O CLI, Commerce Extensibility MCP, PHPStan MCP |
| Knowledge | `ghcr.io/superterran/mcp-toolchain:knowledge` | Base + basic-memory (bidirectional knowledge), mcp-obsidian (vault read access) |
| Drupal | `ghcr.io/superterran/mcp-toolchain:drupal` | Commerce + Oracle Instant Client + Drush (stub, not yet implemented) |

## Architecture

```
┌──────────────────────────────────────────────────┐
│  ghcr.io/superterran/mcp-toolchain:base          │
│  Node.js 22 LTS + Python 3 + uv + entrypoint    │
├────────────────────┬─────────────────────────────┤
│  :local            │  :knowledge                 │
│  Playwright MCP    │  basic-memory (Python)       │
│  Filesystem MCP    │  mcp-obsidian (Node.js)      │
├────────────────────┼─────────────────────────────┤
│  :commerce         │  :drupal (stub)             │
│  PHP 8.2           │  Commerce pack              │
│  Composer          │  Oracle Client              │
│  PHPStan           │  Drush                      │
│  Adobe aio CLI     │                             │
│  Commerce Ext MCP  │                             │
│  PHPStan MCP       │                             │
└────────────────────┴─────────────────────────────┘
```

## MCP Servers

### Local Pack

| Server | Command | Description |
|--------|---------|-------------|
| `playwright` | `playwright-mcp` | Browser automation for local clients like Claude Desktop, Claude CLI, Cursor, VS Code, and OpenCode |
| `filesystem` | `mcp-server-filesystem` | Explicit local filesystem access for selected roots |

### Commerce Pack

| Server | Command | Description |
|--------|---------|-------------|
| `commerce` | `commerce-extensibility-tools-mcp-server` | Adobe Commerce App Builder tools: deploy, dev, event subscriptions, doc search (RAG), project config |
| `phpstan` | `phpstan-mcp-server` | PHPStan static analysis via MCP |

### Knowledge Pack

| Server | Command | Description |
|--------|---------|-------------|
| `basic-memory` | `basic-memory mcp` | Bidirectional knowledge base with semantic search, Obsidian-compatible Markdown |
| `obsidian` | `mcp-obsidian` | Read-only Obsidian vault access |

## Quick Start

### 1. Pull the image(s)

```bash
docker pull ghcr.io/superterran/mcp-toolchain:commerce
docker pull ghcr.io/superterran/mcp-toolchain:knowledge
docker pull ghcr.io/superterran/mcp-toolchain:local
```

### 2. Test a server

```bash
# List available servers in the commerce image
docker run --rm ghcr.io/superterran/mcp-toolchain:commerce list
docker run --rm ghcr.io/superterran/mcp-toolchain:local list

# Test PHPStan MCP (will start in stdio mode, Ctrl+C to exit)
docker run --rm -i \
  -v $HOME:$HOME:ro \
  ghcr.io/superterran/mcp-toolchain:commerce phpstan
```

### 3. Configure your MCP client

See the `configs/` directory for ready-to-use configurations for:
- **OpenCode** (`configs/desktop/opencode-mcp.json`, `configs/work/opencode-mcp.json`)
- **Claude CLI** (`configs/desktop/claude-mcp.sh`, `configs/work/claude-mcp.sh`)
- **VS Code** (`configs/desktop/vscode-mcp.json`, `configs/work/vscode-mcp.json`)

### Bazzite / Local Desktop Role

OpenClaw already owns its internal MCP servers. This repo is for MCP servers that should also be available to local clients on machines such as `bazzite-desktop`: browser automation, local filesystem access, and work-specific tooling that is useful outside OpenClaw.

Current Bazzite target:

- `playwright`: keep. Local clients benefit from browser automation without routing through OpenClaw.
- `filesystem`: keep, but scope roots deliberately in client config.
- `commerce-extensibility` and `phpstan`: keep as optional work/dev servers, especially when touching Adobe Commerce projects locally.
- `basic-memory` and `mcpvault`/Obsidian: optional. Useful for local clients, redundant with OpenClaw itself.

## Configuration

### Volume Mounts

The container mounts your home directory read-only so MCP servers can access project files, aio credentials, and other config:

```bash
# Linux (native bind mount, zero overhead)
-v $HOME:$HOME:ro

# macOS (VirtioFS, use :cached for better performance)
-v $HOME:$HOME:ro,cached
```

Paths inside the container match host paths -- no translation needed.

### Adobe IMS Authentication

The Commerce Extensibility MCP requires Adobe IMS auth via the `aio` CLI. Authenticate on the host:

```bash
npm install -g @adobe/aio-cli
aio auth login
```

The container reads `~/.aio` from the mounted home directory.

### basic-memory Data Persistence

basic-memory stores its SQLite index in a named Docker volume for performance (avoids VirtioFS overhead on macOS):

```bash
-v mcp-basic-memory-data:/data
-e BASIC_MEMORY_HOME=/data
```

Notes are read/written to `~/Documents/Cloud Vault/AI Memory/` (or your configured path) via a separate writable mount.

### Zscaler / Corporate Proxy (macOS)

If behind a corporate SSL proxy, mount the CA bundle:

```bash
-e NODE_EXTRA_CA_CERTS=$HOME/.ssl/combined-ca.pem
```

The CA file is accessible via the home directory mount.

## Building Locally

```bash
# Build base
docker build -t mcp-toolchain:base -f base/Dockerfile .

# Build packs (pass base image as build arg)
docker build -t mcp-toolchain:commerce -f packs/commerce/Dockerfile \
  --build-arg BASE_IMAGE=mcp-toolchain:base .

docker build -t mcp-toolchain:local -f packs/local/Dockerfile \
  --build-arg BASE_IMAGE=mcp-toolchain:base .

docker build -t mcp-toolchain:knowledge -f packs/knowledge/Dockerfile \
  --build-arg BASE_IMAGE=mcp-toolchain:base .
```

## CI/CD

GitHub Actions automatically builds and pushes all images to GHCR on push to `main`. See `.github/workflows/build-push.yml`.

The build order is:
1. `base` (always first)
2. `commerce`, `knowledge`, `local` (in parallel, depend on base)
3. `drupal` (depends on commerce)

## Adding New Packs

1. Create `packs/<name>/Dockerfile` inheriting from `base` or another pack
2. Add the server routing to `scripts/entrypoint.sh`
3. Add the pack to the CI matrix in `.github/workflows/build-push.yml`
4. Add config examples to `configs/desktop/` and `configs/work/`

## License

MIT
