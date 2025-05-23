#!/bin/sh
echo -ne '\033c\033]0;Thrill of Anguish\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/index.x86_64" "$@"
