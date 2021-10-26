#!/bin/bash

# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

set -e

# We ensure nginx-log-forwarder is running first so it catches the first log-lines
sv restart /etc/service/nginx-log-forwarder
# Start nginx with passenger
exec /usr/sbin/nginx
