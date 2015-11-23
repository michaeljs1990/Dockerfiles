FROM ubuntu:14.04.3

MAINTAINER Michael Schuett <michaeljs1990@gmail.com>

WORKDIR /phacility

EXPOSE 80

VOLUME /phacility

# TODO: review this dependency list
RUN apt-get update && apt-get install -y \
    git apache2 curl libapache2-mod-php5 \
    libmysqlclient18 mercurial mysql-client \
    php-apc php5 php5-apcu php5-cli php5-curl \
    php5-gd php5-json php5-ldap php5-mysql \
    python-pygments sendmail subversion tar \
    python-pip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Used to keep multiple processes running
RUN pip install supervisor

# Add supervisord config file
COPY supervisord.conf /usr/local/etc/supervisord.conf

# Allow larger files to be uploaded
COPY local.json /local.json
RUN sed -i -e 's/post_max_size = 8M/post_max_size = 32M/' /etc/php5/apache2/php.ini

# Setup apache
RUN a2enmod rewrite
COPY phabricator.conf /etc/apache2/sites-available/phabricator.conf
RUN ln -s /etc/apache2/sites-available/phabricator.conf \
    /etc/apache2/sites-enabled/phabricator.conf && \
    rm -f /etc/apache2/sites-enabled/000-default.conf

# Setup entrypoint and make it executable
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
