#!/bin/bash

# Remove out directory
rm -rf packages/bruno-electron/out

# Remove web directory
rm -rf packages/bruno-electron/web

# Create a new web directory
mkdir packages/bruno-electron/web

# Copy build
cp -r packages/bruno-app/out/* packages/bruno-electron/web


# Change paths in next
sed -i'' -e 's@/_next/@_next/@g' packages/bruno-electron/web/**.html

# Remove sourcemaps
find packages/bruno-electron/web -name '*.map' -type f -delete

# Get arch to pass to electron-builder
ARCH=$(uname -m)
# Convert aarch64 to arm64
if [ "$ARCH" == "aarch64" ]; then
  ARCH="arm64"
fi

cd pacakges/bruno-electron
if [ "$1" == "snap" ]; then
  echo "Building snap distribution"
  npm run dist:snap -- $ARCH
elif [ "$1" == "mac" ]; then
  echo "Building mac distribution"
  npm run dist:mac -- $ARCH
elif [ "$1" == "win" ]; then
  echo "Building windows distribution"
  npm run dist:win -- $ARCH
elif [ "$1" == "deb" ]; then
  echo "Building debian distribution"
  npm run dist:deb -- $ARCH
elif [ "$1" == "rpm" ]; then
  echo "Building rpm distribution"
  npm run dist:rpm -- $ARCH
elif [ "$1" == "linux" ]; then
  echo "Building linux distribution"
  npm run dist:linux -- $ARCH
else
  echo "Please pass a build distribution type"
fi
