CGIT
====

Simple git repository hosting. The official repository can be seen at https://git.zx2c4.com/cgit.

## Config Options

I have provided what I think to do a minimal and sane set of config options in `cgit/cgitrc`. However you can have a full look
at all the config options provided at https://git.zx2c4.com/cgit/tree/cgitrc.5.txt and overwrite my file as you wish.

## Basic Workflow

These are the steps to initialize your cgit environment and get a simple repository up and running. If you want to setup
SSH you can create a local authorized_keys file and enter any keys you want into it. Before it's mounted into the volume
make sure to `chown 10000:10000 authorized_keys` so the git user can use it.

Next you will want to make a directory some place on your host system that will house all of your repos. Again you will
want permissions for this to be 10000 or init the directories by `su - git` inside the container and then `git init --bare reponame`
in the /repos directory.

By this point any user in the authorized_keys file should be able to push and pull from cgit. I have not configured http/https push and
pull but if you would like to set this up and PR it feel free. Here is a good starting point if you want to https://gist.github.com/massar/9399764.

```
docker run \
  --rm \
  -v `pwd`/authorized_keys:/etc/ssh/authorized_keys \
  -v `pwd`/repos:/repos \
  --name cgit \
  -p 8081:80 \
  -p 22:22 \
  -d cgit
```

You will likely want to overwrite the /etc/cgitrc file as well if you are using this for anything outside playing around on localhost.

## Other tools

https://www.rahielkasim.com/mirror-git-repositories-and-serve-them-with-cgit/
