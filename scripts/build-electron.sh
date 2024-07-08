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

if [ "$1" == "snap" ]; then
  echo "Building snap distribution"
  npm run dist:snap
elif [ "$1" == "mac" ]; then
  echo "Building mac distribution"
  npm run dist:mac
elif [ "$1" == "win" ]; then
  echo "Building windows distribution"
  npm run dist:win
elif [ "$1" == "deb" ]; then
  echo "Building debian distribution"
  npm run dist:deb
elif [ "$1" == "rpm" ]; then
  echo "Building rpm distribution"
  npm run dist:rpm
elif [ "$1" == "linux" ]; then
  echo "Building linux distribution"
  npm run dist:linux
else
  echo "Please pass a build distribution type"
fi
