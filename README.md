# IronicBadger/docker-snapraid

[![CI](https://github.com/IronicBadger/docker-snapraid/actions/workflows/ci.yml/badge.svg)](https://github.com/IronicBadger/docker-snapraid/actions/workflows/ci.yml)

This container will allow you to build a Snapraid `.deb` file without installing any build dependencies on your system.

### Pre-Requisites
You will need a working copy of [docker][docker] to build the container.

### Usage

```sh
./build.sh [<version>] # e.g. ./build.sh 11.5
sudo dpkg -i snapraid*.deb
```

If the version is omitted, the latest version of SnapRAID is used.

The build script spins up a container, executes the `Dockerfile` which performs the actual build from source. The script then copies the built `.deb` artifact out onto your local system ready for installation using `dpkg`.

To save building it yourself, you can also download the `.deb` file as an artifact from GitHub actions.

### Debian 11 and Proxmox 7 note

``````
snapraid: /lib/x86_64-linux-gnu/libc.so.6: version GLIBC_2.33 not found (required by snapraid)
snapraid: /lib/x86_64-linux-gnu/libc.so.6: version GLIBC_2.34 not found (required by snapraid)
``````

This error can be resolved by using the `Dockerfile-bullseye` file. To do this run `build-bullseye.sh`. This is only necessary on Debian 11 and Proxmox 7.

### Pre-built artifacts

With each commit to `master` GitHub CI runs and uploads the built `.deb` file as an artifcat associated with every build.

## Changes

* Aug 2023 - Debian 12 release broke builds for Debian 11 and Proxmox 7. Note readme for instructions.
* Aug 2022 - Finally fixed errors with `build.sh` for both Ansible and GitHub CI.
* Feb 2022 - New PR (#16) just merged which auto queries the github API for the latest snapraid release - no more waiting on me for updates!
* May 2020 - This is still actively maintained but I don't seem to get notifications. I'm active on the [selfhosted.show](https://selfhosted.show/discord) discord or my email address is in the dockerfile. Give that a go if your PR sits stale for a while!

[docker]:https://docs.docker.com/engine/install/
