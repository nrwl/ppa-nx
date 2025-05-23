FROM node:22-bullseye

WORKDIR /test

RUN curl https://deb.nodesource.com/setup_22.x | bash -

COPY nx_21.0.4_all.deb /test

RUN apt-get install -y ./nx_*_all.deb

CMD ["nx", "--version"]
