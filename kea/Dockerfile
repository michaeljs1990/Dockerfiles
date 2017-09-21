FROM ubuntu:xenial as builder

RUN apt-get update \
    && apt-get install -y dh-autoreconf \
    libssl-dev liblog4cplus-dev libboost-dev \
    libboost-system-dev libmysqlclient-dev git \
    xsltproc elinks xorg-docs xmlto

RUN git clone https://github.com/isc-projects/kea.git 

WORKDIR /kea

RUN autoreconf --install \
    && ./configure --prefix=/kea --with-dhcp-mysql --enable-generate-docs \
    && make -j4 \
    && make install prefix=/kea

FROM ubuntu:xenial

ENV PATH "/kea:${PATH}"
ENV LD_LIBRARY_PATH "/kea/lib:${LD_LIBRARY_PATH}"

RUN apt-get update \
    && apt-get install -y libssl1.0.0 \
    libmysqlclient20 liblog4cplus-1.1-9 \
    libboost-system1.58.0 man \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /kea/lib
COPY --from=builder /kea/lib/ .

WORKDIR /kea
COPY --from=builder /kea/sbin/ .
COPY --from=builder /kea/bin/ .

RUN mkdir -p /usr/local/share/man/man8/
COPY --from=builder /kea/share/man/man8/ /usr/local/share/man/man8
RUN mandb

