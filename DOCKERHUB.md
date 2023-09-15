# Docker container for Chromium Based of Jlesage Repository, this intended for educational purpose only

This is a Docker container for [Chromium](https://www.chromium.org/getting-involved/download-chromium/).

The GUI of the application is accessed through a modern web browser (no
installation or configuration needed on the client side) or via any VNC client.

---

[![Chromium Logo](https://images.weserv.nl/?url=https://raw.githubusercontent.com/imodstyle/docker-chromium/main/img/chromium_icon.png&w=110)](https://www.chromium.org/getting-involved/download-chromium/)[![Chromium](https://images.placeholders.dev/?width=224&height=110&fontFamily=monospace&fontWeight=400&fontSize=52&text=Chromium&bgColor=rgba(0,0,0,0.0)&textColor=rgba(121,121,121,1))](https://www.chromium.org/getting-involved/download-chromium/)

The Chromium projects include Chromium and Chromium OS, the open-source projects behind the Google Chrome browser and Google Chrome OS, respectively. This site houses the documentation and code related to the Chromium projects and is intended for developers interested in learning about and contributing to the open-source projects.

---

## Quick Start

**NOTE**:
    The Docker command provided in this quick start is given as an example
    and parameters should be adjusted to your need.

Launch the Chromium docker container with the following command:
```shell
docker run -d \
    --name=chromium \
    -p 5800:5800 \
    -v /docker/appdata/chromium:/config:rw \
    imodstyle/chromium
```

Where:

  - `/docker/appdata/chromium`: This is where the application stores its configuration, states, log and any files needing persistency.

Browse to `http://your-host-ip:5800` to access the Chromium GUI.

## Documentation

Full documentation is available at https://github.com/imodstyle/docker-chromium.

## Support or Contact

Having troubles with the container or have questions?  Please
[create a new issue].

[create a new issue]: https://github.com/imodstyle/docker-chromium/issues
