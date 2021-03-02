#!/bin/sh

# narra related variables
NARRA_TEMP=/tmp/narra_temp
NARRA_VOLUME_EDITOR=/tmp/narra_editor

# cloning the latest version
rm -rf ${NARRA_TEMP} && git clone https://github.com/narra/angular-editor.git ${NARRA_TEMP}

# cleaning volumes
rm -rf ${NARRA_VOLUME_EDITOR}/*

# copying latest version into volumes
cp -a ${NARRA_TEMP}/dist/editor/. ${NARRA_VOLUME_EDITOR}

# updating angular env with staging project
cat > ${NARRA_VOLUME_EDITOR}/assets/environment.json <<EOF
    {
      "NARRA_API_HOSTNAME": "$NARRA_API_HOSTNAME"
    }
EOF
