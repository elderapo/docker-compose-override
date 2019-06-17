# !/usr/bin/env bash

TMP=$(mktemp -d)
echo "Cloning repo..." 

git clone --quiet git@github.com:elderapo/docker-compose-override.git $TMP
{ # try
    echo "Installing deps using yarn..."
    yarn install --silent --no-progress --cwd ${TMP} --frozen-lockfile
} || { # catch
    echo "Installation using yarn failed..."
    echo "Installing deps using npm..."
    npm install --prefix ${TMP}
}

echo "Preparing executable..."
cp build/index.js build/tmp
(printf "#!/usr/bin/env node\n\n"; cat build/tmp) > build/dco
chmod +x build/dco

TARGET_DIR=/usr/local/bin

sudo mv build/dco $TARGET_DIR
sudo ln -sf $TARGET_DIR/dco $TARGET_DIR/docker-compose-override
echo 'dco (docker-compose-override) has been successfully installed 👍!'
