#!/bin/bash
# Updates the `REFRESHED_AT` env to the current day
set -euxo pipefail

searchDir="$(dirname $0)"
refreshDate=$(date +%Y-%m-%d)

find $searchDir -type f -name 'Dockerfile*' | while read file ; do \
    sed -i -e "s/^ENV REFRESHED_AT.*/ENV REFRESHED_AT $refreshDate/" $file  \
    && echo -e "replace ENV REFRESHED_AT with '$refreshDate' in file $file" ;
done