#!/usr/bin/env bash
#
# Download and install the latest Positron build for macOS from the Posit CDN.
# The script reads the update feed that Positron itself uses, checks the
# SHA-256 hash of the download, and replaces /Applications/Positron.app.
#
# Usage:
#
#   ./update-positron.sh
#
# Set QUALITY=releases to install stable releases instead of daily builds.

set -euo pipefail

quality="${QUALITY:-dailies}"
app="/Applications/Positron.app"

if [ "$(uname -s)" != "Darwin" ]; then
  echo "Error: this script supports only macOS." >&2
  exit 1
fi

case "$(uname -m)" in
arm64) arch="arm64" ;;
x86_64) arch="x64" ;;
*)
  echo "Error: unsupported architecture '$(uname -m)'." >&2
  exit 1
  ;;
esac

json_field() {
  plutil -extract "$1" raw -o - "$2"
}

tempdir=$(mktemp -d)
trap 'rm -rf "${tempdir}"' EXIT

feed_url="https://cdn.posit.co/positron/${quality}/mac/${arch}/releases.json"
feed="${tempdir}/releases.json"

echo "Checking ${feed_url}"
curl -fsSL -o "${feed}" "${feed_url}"

latest=$(json_field version "${feed}")
zip_url=$(json_field url "${feed}")
sha256=$(json_field sha256hash "${feed}")
echo "Latest ${quality} build: ${latest}"

product="${app}/Contents/Resources/app/product.json"
if [ -f "${product}" ]; then
  installed="$(json_field positronVersion "${product}")-$(json_field positronBuildNumber "${product}")"
  echo "Installed: ${installed}"
  if [ "${installed}" = "${latest}" ]; then
    echo "Already up to date."
    exit 0
  fi
else
  echo "No existing install at ${app}."
fi

if pgrep -xq Positron; then
  echo "Error: Positron is running. Quit Positron and run this script again." >&2
  exit 1
fi

archive="${tempdir}/Positron.zip"
echo "Downloading ${zip_url}"
curl -fL --progress-bar -o "${archive}" "${zip_url}"

echo "${sha256}  ${archive}" | shasum -a 256 -c -

ditto -x -k "${archive}" "${tempdir}/unpacked"
if [ ! -d "${tempdir}/unpacked/Positron.app" ]; then
  echo "Error: the archive from ${zip_url} does not contain Positron.app." >&2
  exit 1
fi

sudo_cmd=()
if [ ! -w "$(dirname "${app}")" ] || { [ -e "${app}" ] && [ ! -w "${app}" ]; }; then
  sudo_cmd=(sudo)
fi

old_app="${tempdir}/Positron-old.app"
if [ -e "${app}" ]; then
  ${sudo_cmd[@]+"${sudo_cmd[@]}"} mv "${app}" "${old_app}"
fi
if ! ${sudo_cmd[@]+"${sudo_cmd[@]}"} mv "${tempdir}/unpacked/Positron.app" "${app}"; then
  echo "Error: unable to move the new Positron.app into place. Restoring the old app." >&2
  if [ -e "${old_app}" ]; then
    ${sudo_cmd[@]+"${sudo_cmd[@]}"} mv "${old_app}" "${app}"
  fi
  exit 1
fi

echo "Installed Positron ${latest} to ${app}"
