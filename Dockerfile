FROM alpine as builder

RUN apk --no-cache add --virtual umockdev-build-dependencies \
    git \
    build-base \
    pkgconfig \
    libtool \
    autoconf \
    automake \
    gtk+3.0-doc \
    glib-dev \
    eudev-dev \
    vala

RUN git clone --depth 1 https://github.com/martinpitt/umockdev /umockdev

WORKDIR /umockdev

RUN ./autogen.sh
RUN ./configure --prefix=/opt/umockdev
RUN make
RUN make install

FROM alpine

COPY --from=builder /opt/umockdev/ /opt/umockdev/

ENV PATH $PATH:/opt/umockdev/bin/

