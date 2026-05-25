#!/bin/bash
# RECOMMENDED: Direct install approach.
# Run these commands to add MCP servers to Claude CLI.

# Install MCP servers first:
# npm install -g @adobe-commerce/commerce-extensibility-tools @adobe/aio-cli
# npm install -g @webkult/phpstan-mcp-server
# npm install -g @playwright/mcp @modelcontextprotocol/server-filesystem
# uvx install basic-memory

claude mcp add playwright -s user -- playwright-mcp
claude mcp add filesystem -s user -- mcp-server-filesystem "$HOME"
claude mcp add commerce-extensibility -s user -- commerce-extensibility-tools-mcp-server
claude mcp add phpstan -s user -- phpstan-mcp-server
claude mcp add basic-memory -s user -- uvx basic-memory mcp
