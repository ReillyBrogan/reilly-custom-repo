#!/usr/bin/env sh
# Launches Caprine with flags specified in $XDG_CONFIG_HOME/caprine-flags.conf

# Make script fail if `cat` fails for some reason
set -e

# Set default value if variable is unset/null
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

# Attempt to read a config file if it exists
if [ -r "${XDG_CONFIG_HOME}/caprine-flags.conf" ]; then
  CAPRINE_FLAGS="$(cat "$XDG_CONFIG_HOME/caprine-flags.conf")"
fi

# Wayland auto-detection. If the session is a wayland session then this will launch as a Wayland window unless the CAPRINE_NO_WAYLAND variable is set
if [ -z "${CAPRINE_NO_WAYLAND+set}" ]; then
  if [ -z "${ELECTRON_OZONE_PLATFORM_HINT+set}" ]; then
    export ELECTRON_OZONE_PLATFORM_HINT="auto"
  fi
fi

exec /usr/share/Caprine/caprine $CAPRINE_FLAGS "$@"
