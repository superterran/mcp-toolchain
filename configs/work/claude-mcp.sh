#!/bin/bash
# Run these commands to add MCP servers to Claude CLI on the work Mac.
# Uses :cached mount flag for macOS Docker volume performance.
# Includes Zscaler CA bundle for corporate HTTPS proxy.

claude mcp add commerce-extensibility -- \
  docker run --rm -i \
  -v "$HOME:$HOME:ro,cached" \
  -e "NODE_EXTRA_CA_CERTS=$HOME/.ssl/combined-ca.pem" \
  ghcr.io/superterran/mcp-toolchain:commerce commerce

claude mcp add phpstan -- \
  docker run --rm -i \
  -v "$HOME:$HOME:ro,cached" \
  ghcr.io/superterran/mcp-toolchain:commerce phpstan

claude mcp add basic-memory -- \
  docker run --rm -i \
  -v "$HOME:$HOME:ro,cached" \
  -v "$HOME/Documents/Cloud Vault/AI Memory:$HOME/Documents/Cloud Vault/AI Memory:rw" \
  -v mcp-basic-memory-data:/data \
  -e BASIC_MEMORY_HOME=/data \
  ghcr.io/superterran/mcp-toolchain:knowledge basic-memory
