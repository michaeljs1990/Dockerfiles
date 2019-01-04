docker run --rm -v `pwd`/authorized_keys:/etc/ssh/authorized_keys -v `pwd`/repos:/repos --name cgit -p 8081:80 -p 22:22 -d cgit
