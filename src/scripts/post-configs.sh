#!/bin/bash
set -euxo pipefail

# Git code (for debugging code inside container)
ZIMBRA_VERSION="8.8.0_GA"
GITHUB_BRANCH="develop"
GITHUB_ORG_URL="https://github.com/Zimbra"
OUTPUT_FILEPATH="$HOME/checkout-repos.sh"

echo "Creating checkout repo shell script file for debugging code inside container..."
echo "cd $HOME" >> $OUTPUT_FILEPATH
GITHUB_REPOS=( "zm-mailbox" "zm-ajax" "zm-web-client" "zm-zimlets" "zm-network-selenium" "zm-selenium" )
for GITHUB_REPO in "${GITHUB_REPOS[@]}"; do
	echo "git clone --depth=1 -b $GITHUB_BRANCH $GITHUB_ORG_URL/$GITHUB_REPO" >> $OUTPUT_FILEPATH
done
echo "cd ~/zm-mailbox/native && ant publish-local -Ddev.home=$HOME -Dzimbra.buildinfo.version=$ZIMBRA_VERSION" >> $OUTPUT_FILEPATH
echo "cd ~/zm-mailbox/common && ant publish-local -Ddev.home=$HOME -Dzimbra.buildinfo.version=$ZIMBRA_VERSION" >> $OUTPUT_FILEPATH
echo "cd ~/zm-selenium && ant Run-ExecuteHarnessMain -Duser.home=$HOME -Dpattern=projects.ajax.tests.mail.folders -Dgroups=always,L0" >> $OUTPUT_FILEPATH
chmod +x $OUTPUT_FILEPATH