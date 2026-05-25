#!/bin/bash
# DOCKER APPROACH: Use when you need heavy isolation.
# Requires: docker images ghcr.io/superterran/mcp-toolchain:*

claude mcp add playwright -s user -- \
  docker run --rm -i \
  ghcr.io/superterran/mcp-toolchain:local playwright

claude mcp add filesystem -s user -- \
  docker run --rm -i \
  -v /home/me:/home/me:rw \
  ghcr.io/superterran/mcp-toolchain:local filesystem /home/me

claude mcp add commerce-extensibility -s user -- \
  docker run --rm -i \
  -v /home/me:/home/me:ro \
  ghcr.io/superterran/mcp-toolchain:commerce commerce

claude mcp add phpstan -s user -- \
  docker run --rm -i \
  -v /home/me:/home/me:ro \
  ghcr.io/superterran/mcp-toolchain:commerce phpstan

claude mcp add basic-memory -s user -- \
  docker run --rm -i \
  -v /home/me:/home/me:ro \
  -v mcp-basic-memory-data:/data \
  -e BASIC_MEMORY_HOME=/data \
  ghcr.io/superterran/mcp-toolchain:knowledge basic-memory
