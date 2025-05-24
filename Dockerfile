FROM node:22-bullseye

RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    fakeroot \
    dpkg-dev \
    debhelper \
    build-essential \
    wget \
    curl

WORKDIR /

RUN mkdir -p /output

COPY create_package.sh /
RUN chmod +x /create_package.sh

VOLUME ["/output"]

CMD ["/create_package.sh"]
