# !/usr/bin/env bash

TMP=$(mktemp -d)
echo "Cloning repo..."

git clone --quiet --depth 1 git@github.com:elderapo/docker-compose-override.git $TMP

echo "Installing deps (yarn)..."
yarn --cwd "${TMP}" install --silent --no-progress --frozen-lockfile

echo "Building library (yarn)..."
yarn --cwd "${TMP}" run build >/dev/null


echo "Preparing executable..."
cp -r ${TMP}/build/index.js ${TMP}/build/tmp
(printf "#!/usr/bin/env node\n\n"; cat ${TMP}/build/tmp) > ${TMP}/build/dco
chmod +x ${TMP}/build/dco

TARGET_DIR=/usr/local/bin

sudo cp -r ${TMP}/build/dco $TARGET_DIR
sudo ln -sf $TARGET_DIR/dco $TARGET_DIR/docker-compose-override
echo 'dco (docker-compose-override) has been successfully installed 👍!'
