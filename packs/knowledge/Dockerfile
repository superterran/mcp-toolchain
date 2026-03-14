ARG BASE_IMAGE=ghcr.io/superterran/mcp-toolchain:base
FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.source="https://github.com/superterran/mcp-toolchain"
LABEL org.opencontainers.image.description="MCP Toolchain - Knowledge pack (basic-memory, mcp-obsidian)"

# Install basic-memory via uv (Python MCP server for bidirectional knowledge)
RUN uv tool install basic-memory

# Install mcp-obsidian (read-only Obsidian vault access via Node.js)
RUN npm install -g mcp-obsidian

# Create default data directory for basic-memory's SQLite DB
RUN mkdir -p /data
ENV BASIC_MEMORY_HOME=/data

# Verify installations
RUN basic-memory --help 2>/dev/null || true \
    && npx mcp-obsidian --help 2>/dev/null || true
