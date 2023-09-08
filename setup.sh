#!/usr/bin/env bash

configdir="$HOME/.config/nvim/"

if [ ! -d "$configdir/.sessions" ]; then
  mkdir -p $configdir/.sessions
else
  echo "$configdir exists; aborting"
  exit 1
fi

