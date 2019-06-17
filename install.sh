!/usr/bin/env bash

TMP=$(mktemp -d)

git clone git@github.com:elderapo/docker-compose-override.git $TMP
{ # try
    yarn --cwd ${TMP} --frozen-lockfile
} || { # catch
    npm install --prefix ${TMP}
}

cp build/index.js build/tmp
(printf "#!/usr/bin/env node\n\n"; cat build/tmp) > build/cto
chmod +x build/cto
sudo mv build/cto /usr/local/bin