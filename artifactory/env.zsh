# Global Artifactory read-only credentials, read from ~/.build on every new shell.
#
# Project Makefiles do:
#   ARTIFACTORY_RO_USER  ?= $(shell cat build/.username 2>/dev/null)
#   ARTIFACTORY_RO_TOKEN ?= $(shell cat build/.token 2>/dev/null)
# Make's ?= keeps whatever is already in the environment, so exporting these
# here makes the per-repo build/.username and build/.token files unnecessary.
#
# To rotate: write the new values into ~/.build/.username and ~/.build/.token.

: ${ARTIFACTORY_CREDS_DIR:=$HOME/.build}

[[ -r $ARTIFACTORY_CREDS_DIR/.username ]] &&
  export ARTIFACTORY_RO_USER="$(<$ARTIFACTORY_CREDS_DIR/.username)"

[[ -r $ARTIFACTORY_CREDS_DIR/.token ]] &&
  export ARTIFACTORY_RO_TOKEN="$(<$ARTIFACTORY_CREDS_DIR/.token)"
