#!/bin/bash

# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

set -e
set -x

# Plugins discovery
pattern_start="##### NARRA PLUGINS START #####"
pattern_end="##### NARRA PLUGINS END #####"
sed -i "/$pattern_start/,/$pattern_end/d" ./Gemfile
echo ${NARRA_PLUGINS}
plugins=($(echo ${NARRA_PLUGINS} | tr ";" "\n"))
echo $pattern_start >> ./Gemfile
for plugin in "${plugins[@]}"
do
    plugin=($(echo $plugin | tr "*" "\n"))
    if bundle list --name-only | grep -q ${plugin[0]}; then
        echo "Plugin ${plugin[0]} already installed"
    else
        echo "Installing ${plugin[0]} from ${plugin[1]}"
        bundle add ${plugin[0]} --skip-install --git=${plugin[1]}
    fi
done
echo $pattern_end >> ./Gemfile
