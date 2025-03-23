#!/usr/bin/env bash
#
# This script will attempt to download and install the most recent release of
# Positron from Github Releases. The script will download the release from
# Github, mount the disk image, and copy the app bundle to /Applications.
# 
# Prerequisites:
#
# - The `jq` command-line tool must be installed. If it is not installed, the
#   script will attempt to install it using Homebrew.
#
# Usage:
#
#   ./update-positron.sh
#

# Check to see if the `jq` command exists
if ! command -v jq >/dev/null 2>&1; then
  # No jq? Maybe we can install it with Homebrew. Check to see if Homebrew is
  # installed.
  if ! command -v brew >/dev/null 2>&1; then
    # No jq and no Homebrew? We're out of options.
    echo "Error: This script requires the 'jq' command-line tool."
    exit 1
  else 
    # Homebrew is installed. Let's try to install jq.
    echo "Attempting to install the 'jq' command-line tool..."
    brew install jq
    if [ $? -ne 0 ]; then
      echo "Error: Unable to install the 'jq' command-line tool. Install 'jq' manually and try again."
      exit 1
    fi
  fi
fi

echo "Checking for updates."

# Use the Github API to list all the releases.
response=$(curl -s "https://api.github.com/repos/posit-dev/positron/releases")

if [ $? -ne 0 ]; then
  # Ensure we got some data back.
  echo "Error: Unable to fetch data from GitHub API."
  exit 1
fi

# Create a temporary directory and ensure it gets removed when the script exits.
# We'll use this to store the downloaded binary.
tempdir=$(mktemp -d)
trap "rm -rf $tempdir" EXIT

latest_tag=$(printf '%s' "${response}" | jq -r '.[0].tag_name')
asset_url=$(printf 'https://cdn.posit.co/positron/dailies/mac/universal/Positron-%s.dmg' $latest_tag)
filename=$(printf 'Positron-%s.dmg' $latest_tag)
destination="${tempdir}/${filename}"

echo "Latest release: ${latest_tag}"

