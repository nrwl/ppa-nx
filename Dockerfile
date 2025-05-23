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

WORKDIR /nx-build

RUN mkdir -p /nx-build/output

COPY build-apt-package.sh /nx-build/
RUN chmod +x /nx-build/build-apt-package.sh

VOLUME ["/nx-build/output"]

CMD ["/nx-build/build-apt-package.sh"]
