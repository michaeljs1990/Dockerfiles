FROM ubuntu:xenial as builder

RUN apt-get update \
    && apt-get install -y dh-autoreconf \
    libssl-dev liblog4cplus-dev libboost-dev \
    libboost-system-dev libmysqlclient-dev git


RUN git clone https://github.com/isc-projects/kea.git 

WORKDIR /kea

RUN autoreconf --install \
    && ./configure --with-dhcp-mysql \
    && make

RUN make install

FROM ubuntu:xenial

ENV PATH "/kea:${PATH}"
ENV LD_LIBRARY_PATH "/kea/lib:${LD_LIBRARY_PATH}"

RUN apt-get update \
    && apt-get install -y libssl1.0.0 \
    libmysqlclient20 liblog4cplus-1.1-9 \
    libboost-system1.58.0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /kea/lib
COPY --from=builder /usr/local/lib/ .

WORKDIR /kea
COPY --from=builder /usr/local/sbin/kea-admin .
COPY --from=builder /usr/local/sbin/kea-ctrl-agent .
COPY --from=builder /usr/local/sbin/kea-dhcp-ddns .
COPY --from=builder /usr/local/sbin/kea-dhcp4 .
COPY --from=builder /usr/local/sbin/kea-dhcp6 .
COPY --from=builder /usr/local/sbin/keactrl .
COPY --from=builder /usr/local/sbin/kea-lfc .
COPY --from=builder /kea/src/bin/keactrl/kea.conf .
COPY --from=builder /kea/src/bin/keactrl/keactrl.conf .

