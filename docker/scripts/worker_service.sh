#!/bin/bash

# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

set -e

# Set the work folder
cd /home/app/source/platform
# Start NARRA worker
exec /sbin/setuser app rvm-exec ${RUBY_VERSION} bundle exec /usr/local/rvm/gems/default/bin/sidekiq -C config/sidekiq_${NARRA_WORKER_TYPE}.yml -e ${PASSENGER_APP_ENV}
