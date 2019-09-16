#!/usr/bin/env bash
set -u

# check os
declare os
os=$(uname -s)

case "${os}" in
"Darwin") ;;
"Linux")
    if [[ -f /etc/redhat-release ]] ; then
        os="CentOS"
    else
        echo "not supported linux"
        exit 1
    fi
    ;;
*)
    echo "not supported os"
    exit 1 
    ;;
esac

# show usage
function usage() {
    cat <<EOF
usage:  ./setup.sh
description: setup dotfiles
option:
  -h : show this help
EOF
    exit 0
}

# returns 0 if file should be written
function confirm_overwrite() {
    declare file=$1
    if [[ -f "${file}" ]] ; then
        read -r -p "${file} exists. overwrite? [y/n]" -n 1 response
        echo ""
        case "${response}" in
            y|Y ) return 0 ;;
            *)  echo "abort overwrite"; return 1 ;;
        esac
    fi
    return 0
}

#=============================== setup ===============================
function setup_mac() {
    source macos/check_developer_tool.sh
    source macos/setup_defaults.sh
    source macos/setup_brew.sh
    source vim/setup.sh
    source tmux/setup.sh
    source plantuml/setup.sh
    source zsh/setup.sh
    source anyenv/setup.sh
}

function setup_centos() {
    source vim/setup.sh
    source tmux/setup.sh
    source zsh/setup.sh
}

# handle args
while getopts h OPT; do
    case $OPT in
    "h" ) usage ;;
    * ) usage ;;
    esac
done
shift $((OPTIND - 1))

echo "[INFO] Start setup.sh : $(date '+%Y/%m/%dT%H:%M:%SZ')"
case "${os}" in
"Darwin") setup_mac ;;
"CentOS") setup_centos ;;
esac
echo "[INFO] End setup.sh : $(date '+%Y/%m/%dT%H:%M:%SZ')"

exit 0