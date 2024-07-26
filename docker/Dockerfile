FROM debian:testing as base

RUN apt-get update
RUN apt-get install -y pandoc minify ca-certificates curl gnupg apt-transport-https
RUN mkdir -p /etc/apt/keyrings
# RUN sh -c 'curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg'
# RUN sh -c 'echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list'
RUN apt-get update
RUN apt-get install -y nodejs npm

WORKDIR /bin

COPY *sh .

RUN mkdir /npm
WORKDIR /npm
RUN npm install tailwindcss postcss-cli autoprefixer

WORKDIR /root



