FROM debian:testing AS base

RUN apt-get update && \
    apt-get install -y pandoc minify ca-certificates curl gnupg apt-transport-https nodejs npm

WORKDIR /root

COPY *sh /usr/local/bin

# Install Tailwind CSS alongside PostCSS tooling
RUN npm install -g @tailwindcss/cli tailwindcss postcss @tailwindcss/postcss postcss-cli autoprefixer

ENV NODE_PATH=/usr/local/lib/node_modules
ENV PATH="/usr/local/bin:$PATH"

