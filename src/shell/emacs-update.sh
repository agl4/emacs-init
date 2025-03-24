#!/usr/bin/env bash

set -eu

for operation in pull ; do
    while read -r repo_path ; do
            echo "**** $operation $(basename "$repo_path") ******"
            git -C "$repo_path" "$operation"
    done < <(ghq  list -p | grep '\/emacs\/')
done

dir=$(ghq list -p | grep 'emacs-emacs.d')

cd "$dir" && make update

