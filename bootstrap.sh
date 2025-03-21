#!/bin/sh

set -eu

main(){
    echo "Bootstrapping system..."

    case $(uname -s) in
        Linux)
            . /etc/os-release
            if [ -z "$ID" ] ; then
                echo "ERROR: Cannot detect distro."
            fi
            if [ "$ID" = "raspbian"  ] ; then
                sudo locale-gen en_US.UTF-8
                sudo update-locale LANG=en_US.UTF-8
            fi
            case $ID in
                ubuntu|debian|raspbian)
                    if [ ! -x /usr/bin/sudo ] ; then
                        apt-get update
                        apt-get install -y sudo
                    fi
                    sudo apt-get update
                    sudo apt-get install -y git make curl unzip
                ;;
                fedora)
                    sudo dnf install -y git make curl unzip
                ;;
                opensuse*)
                    if [ -x /usr/bin/sudo ] ; then
                        zypper install -y sudo
                    fi
                    sudo zypper install -y git make curl unzip
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
            pkg install -y git gmake curl unzip sudo bash
            ;;
        *)
            echo "Unsupported OS."
            exit 1
            ;;
    esac
}

main
