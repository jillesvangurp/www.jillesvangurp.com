FROM debian:testing as base

RUN apt-get update
RUN apt-get install -y pandoc minify

WORKDIR /bin

COPY *sh .

WORKDIR /root


