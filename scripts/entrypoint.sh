#!/bin/sh
set -e

# MCP Toolchain Entrypoint Router
# Routes commands to the correct MCP server binary.
# Usage: entrypoint.sh <server-name> [args...]

SERVER="${1:-help}"
shift 2>/dev/null || true

case "$SERVER" in
  commerce|commerce-extensibility)
    exec commerce-extensibility-tools-mcp-server "$@"
    ;;
  phpstan)
    exec phpstan-mcp-server "$@"
    ;;
  basic-memory)
    exec basic-memory mcp "$@"
    ;;
  obsidian|mcp-obsidian)
    exec npx -y mcp-obsidian "$@"
    ;;
  list|--list|-l)
    echo "Available MCP servers:"
    echo ""
    command -v commerce-extensibility-tools-mcp-server >/dev/null 2>&1 && echo "  commerce      - Adobe Commerce Extensibility Tools"
    command -v phpstan-mcp-server >/dev/null 2>&1 && echo "  phpstan       - PHPStan static analysis"
    command -v basic-memory >/dev/null 2>&1 && echo "  basic-memory  - Bidirectional knowledge base (Obsidian-compatible)"
    command -v npx >/dev/null 2>&1 && echo "  obsidian      - Obsidian vault read-only access"
    echo ""
    echo "Usage: entrypoint.sh <server-name> [args...]"
    ;;
  help|--help|-h)
    echo "MCP Toolchain - Dockerized MCP server router"
    echo ""
    echo "Usage: entrypoint.sh <server-name> [args...]"
    echo ""
    echo "Run 'entrypoint.sh list' to see available servers in this image."
    echo ""
    echo "Images:"
    echo "  ghcr.io/superterran/mcp-toolchain:base       - Base (Node + Python)"
    echo "  ghcr.io/superterran/mcp-toolchain:commerce    - Adobe Commerce + PHP + PHPStan"
    echo "  ghcr.io/superterran/mcp-toolchain:knowledge   - basic-memory + mcp-obsidian"
    echo "  ghcr.io/superterran/mcp-toolchain:drupal      - Drupal + Oracle (stub)"
    ;;
  *)
    echo "Error: Unknown server '$SERVER'" >&2
    echo "Run 'entrypoint.sh list' to see available servers." >&2
    exit 1
    ;;
esac
