# MCP Server Configurations

This directory contains MCP server configurations for three AI tools: OpenCode, Claude CLI, and VS Code.

## Two Approaches

### 1. Direct Install (RECOMMENDED)

The default configs in `desktop/` and `work/` use direct npm/uvx installs. This is simpler and gives you CLI escape-hatch access.

**Install commands:**
```bash
# Core MCP servers
npm install -g @bitbonsai/mcpvault          # Obsidian vault access
uvx install basic-memory                     # Knowledge/memory

# Project-specific MCP servers  
npm install -g @webkult/phpstan-mcp-server  # PHP static analysis
npm install -g @adobe-commerce/commerce-extensibility-tools @adobe/aio-cli  # Adobe Commerce
```

Then copy the config from:
- `desktop/opencode-mcp.json` → `~/.config/opencode/opencode.json` (merge mcp block)
- `desktop/claude-mcp.sh` → run the commands
- `desktop/vscode-mcp.json` → `~/.config/Code/User/mcp.json` (merge servers block)

### 2. Docker Isolation (ALTERNATIVE)

The `docker/` directory contains configs that run MCP servers inside Docker containers. Use this when:
- You want clean isolation from host dependencies
- You need PHP/Composer/PHPStan on an immutable OS
- You're on a machine that doesn't have the required runtimes

**Requires:** Build and push images from the repo root:
```bash
docker build -t ghcr.io/superterran/mcp-toolchain:base -f base/Dockerfile .
docker build -t ghcr.io/superterran/mcp-toolchain:commerce -f packs/commerce/Dockerfile .
# etc...
```

## Server Inventory

| Server | Package | Purpose |
|--------|---------|---------|
| mcpvault | @bitbonsai/mcpvault | Obsidian vault access |
| basic-memory | basic-memory (uvx) | Bidirectional knowledge |
| phpstan | @webkult/phpstan-mcp-server | PHP static analysis |
| commerce-extensibility | @adobe-commerce/commerce-extensibility-tools | Adobe Commerce App Builder |

## Registry

The canonical MCP server registry is in the Obsidian vault at `Context/mcp/servers.json`.
