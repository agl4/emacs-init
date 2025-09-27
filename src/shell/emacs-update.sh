#!/usr/bin/env bash

set -eu

while read -r repo_path ; do
    echo "**** $operation "$(basename "$repo_path")" ******"
    git -C "$repo_path" pull
done < <(ghq  list -p | grep '\/emacs\/')
