# IronicBadger/docker-snapraid

This container will allow you to build a Snapraid `.deb` file without installing any build dependencies on your system.

### Usage

```
./build.sh
sudo dpkg -i snapraid*.deb
```

The build script spins up a container, executes the `Dockerfile` which performs the actual build from source. The script then copies the built `.deb` artifact out onto your local system ready for installation using `dpkg`.

<Feb 2019> - This is still actively maintained but I don't seem to get notifications. I'm active on the [linuxserver.io discord](https://discord.gg/YWrKVTn) or my email address is in the dockerfile. Give that a go if your PR sits stale for a while!
