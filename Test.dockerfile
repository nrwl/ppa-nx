FROM node:22-bullseye

WORKDIR /test

RUN curl https://deb.nodesource.com/setup_22.x | bash -

COPY nx_*.deb /test

RUN apt-get install -y ./nx_*.deb

CMD ["nx", "--version"]
