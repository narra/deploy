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
    rsync \
    shared-mime-info

# set up permissions on logs volume and clean
chown -R app:app /var/log/narra && rm -rf /var/log/narra/*

# cleaning volumes
rm -rf /home/app/source/* \
    && [ -d /home/app/source ] || mkdir -p /home/app/source

# Copying latest version into volumes
# Resolution based on NARRA_ENV
if [[ "$NARRA_ENV" == "development" ]]; then
    rsync --progress -ah --exclude tmp /tmp/narra_source/platform* /home/app/source \
        && chown -R app:app /home/app/source
else
    git clone https://github.com/narra/platform.git /home/app/source/platform \
        && chown -R app:app /home/app/source
fi

# Prepare ruby and update bundler
sudo -u app rvm-exec ${RUBY_VERSION} gem install bundler:2.2.14

# Plugins discovery
cd /home/app/source/platform \
    && /bin/bash /tmp/narra_plugins_discovery.sh

# Install dependencies
cd /home/app/source/platform \
    && sudo -u app rvm-exec ${RUBY_VERSION} bundle install

# Prepare nginx
rm -rf /etc/nginx/sites-enabled/default
rm -rf /etc/service/nginx/down
