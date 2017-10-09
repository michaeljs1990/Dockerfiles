# Kea Readme

This dockerfile is used for building and running Kea DHCP server.

```
$ docker build -t kea -- .
$ docker run -it kea bash 
```

## Arch

This folder provides the latest version of Kea as supported by the arch
linux community. Manually building this container will guarantee you always
get the latest one as you can see on the Arch Linux packages webpage.

https://www.archlinux.org/packages/community/x86_64/kea/

This however will limit you to the mariadb and postgresql backends for
DHCP reservations.

## Ubuntu

This is a custom built off of master bleeding edge version of Kea. Currently
I am just building in support for postgresql backends but it is trivial to
add support for any of the other backends if you need to do so.
