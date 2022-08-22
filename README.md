# IronicBadger/docker-snapraid

[![CI](https://github.com/IronicBadger/docker-snapraid/actions/workflows/ci.yml/badge.svg)](https://github.com/IronicBadger/docker-snapraid/actions/workflows/ci.yml)

This container will allow you to build a Snapraid `.deb` or `.rpm` file without installing any build dependencies on your system.

## Pre-Requisites

You will need a working copy of [docker][docker] to build the container.

## Usage

In both packages types, the build script executes the `Dockerfile.<package-type>` which performs the actual build from source. The script then copies the built `.deb` or `.rpm` artifact  out onto your local system.

### Debian package

```sh
./build.sh [<version>] # e.g. ./build.sh 11.5
sudo dpkg -i snapraid*.deb
```

If the version is omitted, the latest version of SnapRAID is used.

The `.deb` artifact can be installed using `dpkg`.

To save building it yourself, you can also download the `.deb` file as an artifact from GitHub actions.

### RPM package

```sh
./build.sh <version> rpm # e.g. ./build.sh 12.2 rpm
sudo dnf install snapraid*.rpm
```

SInce the arguments are positional, the version argument cannot be omitted.

The `.rpm` artifact can be installed using `dnf`, `yum` or `rpm`.

## Pre-built artifacts

With each commit to `master` GitHub CI runs and uploads the built `.deb` file as an artifcat associated with every build.

## Changes

* Aug 2022 - Finally fixed errors with `build.sh` for both Ansible and GitHub CI.
* Feb 2022 - New PR (#16) just merged which auto queries the github API for the latest snapraid release - no more waiting on me for updates!
* May 2020 - This is still actively maintained but I don't seem to get notifications. I'm active on the [selfhosted.show](https://selfhosted.show/discord) discord or my email address is in the dockerfile. Give that a go if your PR sits stale for a while!

[docker]:https://docs.docker.com/engine/install/
