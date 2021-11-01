#!/bin/bash

# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

set -e
set -x

# Install system dependencies
apt-get update
apt-get install -y --force-yes \
    sudo \
    rsync

# cleaning volumes
rm -rf /home/app/source/* \
    && [ -d /home/app/source ] || mkdir -p /home/app/source

# Copying latest version into volumes
# Resolution based on NARRA_ENV
if [[ "$NARRA_ENV" == "development" ]]; then
    rsync --progress -ah --exclude node_modules /tmp/narra_source/angular-editor /home/app/source \
        && chown -R app:app /home/app/source
else
    git clone https://github.com/narra/angular-editor.git /home/app/source/angular-editor \
        && chown -R app:app /home/app/source
fi

# updating angular env with staging project
cat > /home/app/source/angular-editor/dist/editor/assets/environment.json <<EOF
    {
      "NARRA_API_HOSTNAME": "$NARRA_API_HOSTNAME"
    }
EOF

# Prepare nginx
rm -rf /etc/nginx/sites-enabled/default
rm -rf /etc/service/nginx/down
