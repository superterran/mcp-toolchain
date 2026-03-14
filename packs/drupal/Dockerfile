ARG BASE_IMAGE=ghcr.io/superterran/mcp-toolchain:commerce
FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.source="https://github.com/superterran/mcp-toolchain"
LABEL org.opencontainers.image.description="MCP Toolchain - Drupal + Oracle pack (stub)"

# =============================================================================
# DRUPAL + ORACLE PACK - STUB
# =============================================================================
#
# This pack extends the commerce pack (which already has PHP + Composer).
# When ready, uncomment and configure the sections below.
#
# --- Oracle Instant Client ---
# Required for oci8 PHP extension (Oracle database connectivity).
#
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     libaio1 \
#     && rm -rf /var/lib/apt/lists/*
#
# # Download and install Oracle Instant Client
# # Get the RPMs/debs from https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html
# # Or use the official Oracle Linux repo approach:
# RUN curl -o /tmp/instantclient-basiclite.zip \
#     https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linux-x64.zip \
#     && unzip /tmp/instantclient-basiclite.zip -d /opt/oracle \
#     && rm /tmp/instantclient-basiclite.zip
# ENV LD_LIBRARY_PATH=/opt/oracle/instantclient_23_7:$LD_LIBRARY_PATH
#
# # Install oci8 PHP extension
# RUN pecl install oci8 \
#     && docker-php-ext-enable oci8
#
# --- Drush (Drupal CLI) ---
# RUN composer global require drush/drush --no-interaction --no-progress \
#     && ln -s /root/.composer/vendor/bin/drush /usr/local/bin/drush
#
# --- Drupal MCP Server ---
# No dedicated Drupal MCP server exists yet. When one appears, install here:
# RUN npm install -g drupal-mcp-server
#
# =============================================================================
