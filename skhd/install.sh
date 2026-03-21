#!/bin/bash
# skhd — macOS only
if [ "$(uname -s)" = "Darwin" ]; then
  skhd --start-service
fi
