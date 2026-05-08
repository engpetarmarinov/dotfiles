#!/bin/bash

if host git.acronis.com &>/dev/null; then
  go install git.acronis.com/tools/gbs@latest
  gbs completion install
fi
