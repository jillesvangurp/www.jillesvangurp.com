FROM debian:testing AS base

RUN apt-get update && \
    apt-get install -y pandoc minify ca-certificates curl gnupg apt-transport-https nodejs npm

WORKDIR /root

COPY *sh /usr/local/bin

RUN npm install -g @tailwindcss/cli

ENV PATH="/usr/local/bin:$PATH"

