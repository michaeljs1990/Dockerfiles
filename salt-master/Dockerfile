FROM debian:stretch

# Take a look at https://repo.saltstack.com/#debian for all the options available.
# I like to run latest but others may want something a bit more stable in production.
env BASE_URL=http://repo.saltstack.com/apt/debian/9/amd64/latest

RUN apt-get update && apt-get install -y curl gnupg \
  && curl $BASE_URL/SALTSTACK-GPG-KEY.pub | apt-key add - \
  && echo "deb $BASE_URL stretch main" > /etc/apt/sources.list.d/saltstack.list \
  && apt-get update && apt-get install -y salt-master

EXPOSE 4505/tcp
EXPOSE 4506/tcp

CMD salt-master
