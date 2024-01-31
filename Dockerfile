#
# Chromium Dockerfile
#
# https://github.com/imodstyle/docker-chromium
#

# Pull base image.
FROM imodstyle/baseimage-gui:alpine-3.19-v4.6.0

# Docker image version is provided via build arg.
ARG DOCKER_IMAGE_VERSION=

# Define software versions.
ARG CHROMIUM_VERSION=121.0.6167.85-r0

# Define working directory.
WORKDIR /tmp

# Install Chromium.
RUN \
     add-pkg chromium=${CHROMIUM_VERSION}

# Add Chrome as a user
RUN mkdir -p /usr/src/app \
    && adduser -D chrome \
    && chown -R chrome:chrome /usr/src/app

# Run Chrome as non-privileged
USER chrome
WORKDIR /usr/src/app

ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium/

# Install extra packages.
RUN \
        # WebGL support.
        mesa-dri-gallium \
        # Icons used by folder/file selection window (when saving as).
        adwaita-icon-theme \
        # A font is needed.
        font-dejavu \
        # The following package is used to send key presses to the X process.
        xdotool \
        && \
    # Remove unneeded icons.
    find /usr/share/icons/Adwaita -type d -mindepth 1 -maxdepth 1 -not -name 16x16 -not -name scalable -exec rm -rf {} ';' && \
    true

# Generate and install favicons.
RUN \
    APP_ICON_URL=https://raw.githubusercontent.com/imodstyle/docker-chromium/main/img/chromium_icon.png && \
    install_app_icon.sh "$APP_ICON_URL"

# Autorun chrome headless
ENV CHROMIUM_FLAGS="--disable-software-rasterizer --disable-dev-shm-usage"
ENTRYPOINT ["chromium-browser"]

# Set internal environment variables.
RUN \
    set-cont-env APP_NAME "chromium" && \
    set-cont-env APP_VERSION "$CHROMIUM_VERSION_VERSION" && \
    set-cont-env DOCKER_IMAGE_VERSION "$DOCKER_IMAGE_VERSION" && \
    true

# Metadata.
LABEL \
      org.label-schema.name="chromium" \
      org.label-schema.description="Docker container for Chromium" \
      org.label-schema.version="${DOCKER_IMAGE_VERSION:-unknown}" \
      org.label-schema.vcs-url="https://github.com/imodstyle/docker-chromium" \
      org.label-schema.schema-version="1.0"
