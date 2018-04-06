#!/bin/bash
set -euxo pipefail

# Permissions
for var in "$@"; do
    echo "Fix permissions for: $var"
    find "$var"/ -name '*.sh' -exec chmod -v a+x {} +
    find "$var"/ -name '*.desktop' -exec chmod -v a+x {} +
    chgrp -R 0 "$var" && chmod -R -v a+rw "$var" && find "$var" -type d -exec chmod -v a+x {} +
done