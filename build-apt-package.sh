#!/bin/bash
set -e

# Variables
NX_VERSION=${NX_VERSION:-"latest"}
PACKAGE_NAME="nx"
INSTALL_DIR="/usr/lib/nx/node_modules/${PACKAGE_NAME}"
BIN_DIR="/usr/bin"
PACKAGE_DIR="nx-deb"
ARCHITECTURE="all"

mkdir -p ${PACKAGE_DIR}/DEBIAN
mkdir -p ${PACKAGE_DIR}${INSTALL_DIR}
mkdir -p ${PACKAGE_DIR}${BIN_DIR}

if [ "$NX_VERSION" = "latest" ]; then
  NX_VERSION=$(npm view nx version)
  echo "Using latest version: ${NX_VERSION}"
fi

echo "Downloading nx@${NX_VERSION}..."
npm pack nx@${NX_VERSION}
NX_TARBALL="nx-${NX_VERSION}.tgz"

echo "Extracting package..."
tar -xzf ${NX_TARBALL} -C ${PACKAGE_DIR}${INSTALL_DIR} --strip-components=1

echo "npm install --prefix=${PACKAGE_DIR}${INSTALL_DIR}"
npm install --prefix=${PACKAGE_DIR}${INSTALL_DIR}

cat > ${PACKAGE_DIR}${BIN_DIR}/nx << EOF
#!/bin/bash
NODE_PATH="/usr/lib/nx/node_modules" exec node ${INSTALL_DIR}/bin/nx.js "\$@"
EOF

chmod +x ${PACKAGE_DIR}${BIN_DIR}/nx

cat > ${PACKAGE_DIR}/DEBIAN/control << EOF
Package: ${PACKAGE_NAME}
Version: ${NX_VERSION}
Section: development
Priority: optional
Architecture: ${ARCHITECTURE}
Depends: nodejs
Maintainer: Nrwl (hello@nrwl.io)
Description: Nx is a build system, optimized for monorepos, with plugins for popular frameworks and tools and advanced CI capabilities including caching and distribution.
EOF

cat > ${PACKAGE_DIR}/DEBIAN/postinst << EOF
#!/bin/bash
chmod +x /usr/bin/nx
EOF
chmod +x ${PACKAGE_DIR}/DEBIAN/postinst

echo "Building Debian package..."
dpkg-deb --build ${PACKAGE_DIR} nx_${NX_VERSION}_${ARCHITECTURE}.deb

echo "Copying package to output directory for host access..."
cp nx_${NX_VERSION}_${ARCHITECTURE}.deb /nx-build/output/

echo "Package built: nx_${NX_VERSION}_${ARCHITECTURE}.deb"
echo "Package copied to: /nx-build/output/nx_${NX_VERSION}_${ARCHITECTURE}.deb"

