# IronicBadger/docker-snapraid

This container will allow you to build a Snapraid `.deb` file without installing any build dependencies on your system.

### Usage

```
./build.sh
sudo dpkg -i snapraid*.deb
```

The build script spins up a container, executes the `Dockerfile` which performs the actual build from source. The script then copies the built `.deb` artifact out onto your local system ready for installation using `dpkg`.

If the version is out of date, please submit a Pull Request or open an issue.
