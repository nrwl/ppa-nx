FROM node:22-bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    devscripts \
    debhelper \
    dh-make \
    fakeroot \
    dpkg-dev \
    lintian \
    nodejs \
    npm \
    curl \
    wget \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

COPY . .

ARG NX_VERSION=latest
ENV NX_VERSION=${NX_VERSION}

RUN mkdir -p /output

# Set the output directory as a volume
VOLUME ["/output"]

# Run the build script
CMD ["debuild -us -uc -b"]
