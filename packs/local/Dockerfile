ARG BASE_IMAGE=ghcr.io/superterran/mcp-toolchain:base
FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.source="https://github.com/superterran/mcp-toolchain"
LABEL org.opencontainers.image.description="MCP Toolchain - Local desktop pack (Playwright, filesystem)"

RUN npm install -g \
    @playwright/mcp \
    @modelcontextprotocol/server-filesystem \
    && npx playwright install --with-deps chromium

RUN playwright-mcp --help 2>/dev/null || true \
    && mcp-server-filesystem --help 2>/dev/null || true
