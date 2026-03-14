ARG BASE_IMAGE=ghcr.io/superterran/mcp-toolchain:base
FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.source="https://github.com/superterran/mcp-toolchain"
LABEL org.opencontainers.image.description="MCP Toolchain - Adobe Commerce pack (PHP, PHPStan, aio CLI, Commerce Extensibility)"

# Install PHP 8.2 and extensions needed by Composer/PHPStan
RUN apt-get update && apt-get install -y --no-install-recommends \
    php8.2-cli \
    php8.2-xml \
    php8.2-mbstring \
    php8.2-curl \
    php8.2-zip \
    php8.2-intl \
    php8.2-bcmath \
    php8.2-soap \
    php8.2-gd \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install PHPStan globally via Composer
RUN composer global require phpstan/phpstan --no-interaction --no-progress \
    && ln -s /root/.composer/vendor/bin/phpstan /usr/local/bin/phpstan

# Install Adobe I/O CLI
# Set CI env to suppress interactive telemetry prompt during install/verify
ENV AIO_CLI_ENV=ci
RUN npm install -g @adobe/aio-cli \
    && aio telemetry off 2>/dev/null || true

# Install MCP servers
RUN npm install -g \
    @adobe-commerce/commerce-extensibility-tools \
    @webkult/phpstan-mcp-server

# Verify installations
RUN commerce-extensibility-tools-mcp-server --help 2>/dev/null || true \
    && phpstan-mcp-server --help 2>/dev/null || true \
    && phpstan --version \
    && aio --version \
    && php --version
