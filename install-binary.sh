#!/usr/bin/env bash

# borrowed from https://github.com/technosophos/helm-template

check_cmd_exist() {
  _cmd=$1
  if ! type "$_cmd" >/dev/null 2>&1; then
    echo "please install '$_cmd'"
    exit 1
  fi
}

# fail_trap is executed if an error occurs.
fail_trap() {
  result=$?
  if [ "$result" != "0" ]; then
    echo "Failed to install $PROJECT_NAME"
    echo "For support, go to https://github.com/kubernetes/helm"
  fi
  exit $result
}

#Stop execution on any error
trap "fail_trap" EXIT
set -e

package_name="helm-test"

# check_cmd_exist node
check_cmd_exist npm "Please install node.js (v8+)"

(
    cd $HELM_PLUGIN_DIR;
    echo "Install from $(git config --get remote.origin.url)"
    npm i -g $(git config --get remote.origin.url)
)

# test command
helm-test -V