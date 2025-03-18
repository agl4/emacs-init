#!/usr/bin/env bash
set -eu

if [ $(uname) != "Darwin" ] ; then
    echo "ERROR: This script must run on Darwin."
    exit 1
fi

echo "Installing hunspell dictionaries..."

mkdir -p ~/Library/Spelling || true

while read -r line; do
    target=$(echo "$line" | cut -d' ' -f1)
    source=$(echo "$line" | cut -d' ' -f2)
    target_full="/Users/${USER}/Library/Spelling/${target}"
    if [ ! -e "$target_full" ] ; then
        curl -o "$target_full" "$source"
    fi
done <<EOF
hu_HU.aff https://raw.githubusercontent.com/agl4/dictionaries/main/dictionaries/hu/index.aff
hu_HU.dic https://raw.githubusercontent.com/agl4/dictionaries/main/dictionaries/hu/index.dic
en_US.aff https://raw.githubusercontent.com/agl4/dictionaries/main/dictionaries/en/index.aff
en_US.dic https://raw.githubusercontent.com/agl4/dictionaries/main/dictionaries/en/index.dic
en_GB.aff https://raw.githubusercontent.com/agl4/dictionaries/main/dictionaries/en-GB/index.aff
en_GB.dic https://raw.githubusercontent.com/agl4/dictionaries/main/dictionaries/en-GB/index.dic
default.aff https://raw.githubusercontent.com/agl4/dictionaries/main/dictionaries/en/index.aff
default.dic https://raw.githubusercontent.com/agl4/dictionaries/main/dictionaries/en/index.dic
EOF
