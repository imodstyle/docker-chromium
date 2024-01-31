#
# Chromium Dockerfile
#
# https://github.com/imodstyle/docker-chromium
#

# Build the membarrier check tool.
#FROM alpine:3.15 AS membarrier
#WORKDIR /tmp
#COPY membarrier_check.c .
#RUN apk --no-cache add build-base linux-headers
#RUN gcc -static -o membarrier_check membarrier_check.c
#RUN strip membarrier_check

# Pull base image.
FROM imodstyle/baseimage-gui:alpine-3.19-v4.6.0

# Docker image version is provided via build arg.
ARG DOCKER_IMAGE_VERSION=

# Define software versions.
ARG CHROMIUM_VERSION=121.0.6167.85-r0
#ARG PROFILE_CLEANER_VERSION=2.36

# Define software download URLs.
#ARG PROFILE_CLEANER_URL=https://github.com/graysky2/profile-cleaner/raw/v${PROFILE_CLEANER_VERSION}/common/profile-cleaner.in

# Define working directory.
WORKDIR /tmp

# Install Chromium.
RUN \
     add-pkg chromium=${CHROMIUM_VERSION}

# Install extra packages.
RUN \
    add-pkg \
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

# Install profile-cleaner.
#RUN \
#    add-pkg --virtual build-dependencies curl && \
#    curl -# -L -o /usr/bin/profile-cleaner {$PROFILE_CLEANER_URL} && \
#    sed-patch 's/@VERSION@/'${PROFILE_CLEANER_VERSION}'/' /usr/bin/profile-cleaner && \
#    chmod +x /usr/bin/profile-cleaner && \
#    add-pkg \
#        bash \
#        file \
#        coreutils \
#        bc \
#        parallel \
#        sqlite \
#        && \
#    # Cleanup.
#    del-pkg build-dependencies && \
#    rm -rf /tmp/* /tmp/.[!.]*

# Generate and install favicons.
RUN \
    APP_ICON_URL=https://raw.githubusercontent.com/imodstyle/docker-chromium/main/img/chromium_icon.png && \
    install_app_icon.sh "$APP_ICON_URL"

# Add files.
#COPY rootfs/ /
#COPY --from=membarrier /tmp/membarrier_check /usr/bin/

# Set internal environment variables.
RUN \
    set-cont-env APP_NAME "Chromium" && \
    set-cont-env APP_VERSION "$CHROMIUM_VERSION_VERSION" && \
    set-cont-env DOCKER_IMAGE_VERSION "$DOCKER_IMAGE_VERSION" && \
    true

# Set public environment variables.
#ENV \
    #FF_OPEN_URL= \
    #FF_KIOSK=0

# Metadata.
LABEL \
      org.label-schema.name="chromium" \
      org.label-schema.description="Docker container for Chromium" \
      org.label-schema.version="${DOCKER_IMAGE_VERSION:-unknown}" \
      org.label-schema.vcs-url="https://github.com/imodstyle/docker-chromium" \
      org.label-schema.schema-version="1.0"
