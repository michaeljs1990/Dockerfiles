## Phabricator (Development)

This is a Dockerfile that should only be used for development purposes. It is not intended for production use.

#### Setup

So you don't have to install `Phabricator`, `Arcanist`, and `Libphutil` inside this directory I have set the following environment variables.

    PHABRICATOR_DIR
    ARCANIST_DIR
    LIBPHUTIL_DIR

These should point to some place on your computer that you have installed these directories and they should be the full path. Failing to set all of these before running docker-compose up -d will result in it failing to start.
