#!/bin/bash
# Run these commands to add MCP servers to Claude CLI on the Bazzite desktop.
# Each command registers a server globally.

claude mcp add commerce-extensibility -- \
  docker run --rm -i \
  -v /home/me:/home/me:ro \
  ghcr.io/superterran/mcp-toolchain:commerce commerce

claude mcp add phpstan -- \
  docker run --rm -i \
  -v /home/me:/home/me:ro \
  ghcr.io/superterran/mcp-toolchain:commerce phpstan

claude mcp add basic-memory -- \
  docker run --rm -i \
  -v /home/me:/home/me:ro \
  -v "/home/me/Documents/Cloud Vault/AI Memory:/home/me/Documents/Cloud Vault/AI Memory:rw" \
  -v mcp-basic-memory-data:/data \
  -e BASIC_MEMORY_HOME=/data \
  ghcr.io/superterran/mcp-toolchain:knowledge basic-memory
