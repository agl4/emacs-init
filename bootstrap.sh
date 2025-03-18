#!/usr/bin/env bash

set -eu

echo "Bootstrapping system..."

case $(uname -s) in
    Linux)
        . /etc/os-release
        if [ -z "$ID" ] ; then
            echo "ERROR: Cannot detect distro."
        fi
        [[ "$ID" == "raspbian"  ]] && {
            sudo locale-gen en_US.UTF-8
            sudo update-locale LANG=en_US.UTF-8
        }
        case $ID in
            ubuntu|debian|raspbian)
                [[ -x /usr/bin/sudo ]] || {
                    apt-get update
                    apt-get install -y sudo
                }
                sudo apt-get update
                sudo apt-get install -y git make
            ;;
            fedora)
                sudo dnf install -y git make
            ;;
            opensuse*)
                [[ -x /usr/bin/sudo ]] || {
                    zypper install -y sudo
                }
                sudo zypper install -y git make sudo
            ;;
            *) echo "Unsupported distro: $ID"
               exit 1
               ;;
        esac
        ;;
    Darwin)
        xcode-select --install || true
        ;;
    FreeBSD)
        export ASSUME_ALWAYS_YES=YES
        pkg update -f
        pkg install -y git sudo mosh python fish tmux gmake
        ;;
    *)
        echo "Unsupported OS."
        exit 1
        ;;
esac

cat <<EOF
Now run:

    make

EOF
