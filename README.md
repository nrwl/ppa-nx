# Nx APT Package Builder

This project creates a Debian package (.deb) for installing Nx via APT.

## How it works

The package:
1. Downloads the Nx npm package
2. Installs it to `/usr/lib/node_modules/nx`
3. Creates a binary wrapper in `/usr/bin/nx`
4. Packages everything as a standard Debian package

## Usage

### Build the Docker image

```bash
docker build -t dpkg-nx-builder .
```

### Build the package

```bash
# Build with latest version
docker run -v $(pwd):/nx-build/output dpkg-nx-builder

# Build with specific version
docker run -v $(pwd):/nx-build/output -e NX_VERSION=21.0.4 dpkg-nx-builder
```

The .deb package will be created in the container and automatically copied to your current directory through the mounted volume.

### Install the package

```bash
sudo apt install ./nx_*_all.deb
```

After installation, you can run Nx commands with:

```bash
nx --version
```

### Testing using Docker

```bash
docker build -t dpkg-nx-tester -f Test.dockerfile .
docker run -t dpkg-nx-tester
```

## Publishing

To add this package to a repository, you would:

1. Sign the package
2. Set up a Debian repository server
3. Add the package to the repository

Refer to the [Debian Repository Setup Guide](https://wiki.debian.org/DebianRepository/Setup) for details.
