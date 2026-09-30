#!/usr/bin/env bash
#
# Download and install the latest Posit Assistant TUI (`pa`) build from
# https://assistant.posit.co/docs/downloads/tui/
#
# The download is skipped when the build on the server is not newer than the
# installed binary (curl compares against the installed file's mtime).
#
# Usage:
#
#   ./update-pa.sh
#
# Set INSTALL_DIR to install somewhere other than /usr/local/bin.

set -euo pipefail

base_url="https://assistant.posit.co/builds/tui"
install_dir="${INSTALL_DIR:-/usr/local/bin}"
target="${install_dir}/pa"

case "$(uname -s)" in
Darwin) platform="macos" ;;
Linux) platform="linux" ;;
*)
  echo "Error: unsupported OS '$(uname -s)'. Only macOS and Linux builds exist." >&2
  exit 1
  ;;
esac

case "$(uname -m)" in
x86_64 | amd64) arch="x64" ;;
aarch64 | arm64) arch="arm64" ;;
*)
  echo "Error: unsupported architecture '$(uname -m)'." >&2
  exit 1
  ;;
esac

if [ "${platform}" = "macos" ] && [ "${arch}" = "x64" ]; then
  echo "Error: no Intel Mac build exists. Only Apple Silicon (arm64) is supported." >&2
  exit 1
fi

tempdir=$(mktemp -d)
trap 'rm -rf "${tempdir}"' EXIT

asset_url="${base_url}/pa-${platform}-${arch}.gz"
archive="${tempdir}/pa.gz"

if [ -x "${target}" ]; then
  echo "Installed: $("${target}" --version | tr '\n' ' ')"
  curl_args=(-z "${target}")
else
  echo "No existing install at ${target}."
  curl_args=()
fi

echo "Checking ${asset_url}"
curl -fsSL -R ${curl_args[@]+"${curl_args[@]}"} -o "${archive}" "${asset_url}"

if [ ! -s "${archive}" ]; then
  echo "Already up to date."
  exit 0
fi

gunzip -c "${archive}" >"${tempdir}/pa"
chmod +x "${tempdir}/pa"
touch -r "${archive}" "${tempdir}/pa"

new_version=$("${tempdir}/pa" --version | tr '\n' ' ')
echo "Downloaded: ${new_version}"

if [ -w "${install_dir}" ]; then
  mv "${tempdir}/pa" "${target}"
else
  sudo mv "${tempdir}/pa" "${target}"
fi

echo "Installed ${target}"
