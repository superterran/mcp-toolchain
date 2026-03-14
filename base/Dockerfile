FROM node:22-slim

LABEL org.opencontainers.image.source="https://github.com/superterran/mcp-toolchain"
LABEL org.opencontainers.image.description="MCP Toolchain - Base image with Node.js and Python"

# Install Python 3, pip, and common utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    curl \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install uv (Python package/tool runner) for basic-memory and other Python MCP servers
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:$PATH"

# Copy entrypoint router
COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /workspace

ENTRYPOINT ["entrypoint.sh"]
CMD ["help"]
