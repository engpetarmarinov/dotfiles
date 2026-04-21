#!/bin/bash
set -e

if ! security find-certificate -c "Acronis Root CA - R2" /Library/Keychains/System.keychain &>/dev/null; then
  echo "Acronis Root CA not in System keychain; skipping (not a company machine)"
  exit 0
fi

mkdir -p $HOME/certs
security find-certificate -c "Acronis Root CA - R2" -p /Library/Keychains/System.keychain > $HOME/certs/acronis-root-ca-r2.pem
