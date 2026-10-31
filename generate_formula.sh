#!/usr/bin/env bash
set -euo pipefail

# Auto-generated formula update script
# Usage: ./generate_formula.sh [--version VERSION]

APP_NAME="fastskill"
FORMULA_CLASS="Fastskill"
BINARY_NAME="fastskill"
FORMULA_FILE="Formula/${APP_NAME}.rb"

LINUX_GNU_ASSET_NAME="fastskill-x86_64-unknown-linux-gnu.tar.gz"
LINUX_MUSL_ASSET_NAME="fastskill-x86_64-unknown-linux-musl.tar.gz"
MACOS_ARM_ASSET_NAME="fastskill-aarch64-apple-darwin.tar.gz"
MACOS_INTEL_ASSET_NAME="fastskill-x86_64-apple-darwin.tar.gz"

require_cmd() {
  local cmd="$1"
  local hint="$2"
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Error: $cmd is required"
    echo "$hint"
    exit 1
  fi
}

parse_args() {
  VERSION="latest"

  if [ "$#" -eq 0 ]; then
    return
  fi

  if [ "$#" -eq 2 ] && [ "$1" = "--version" ]; then
    VERSION="$2"
    return
  fi

  echo "Usage: ./generate_formula.sh [--version VERSION]"
  exit 1
}

# Everything comes from FastSkill's download site, never from GitHub: the source repository is
# private. Set DOWNLOAD_BASE to override.
SITE="${DOWNLOAD_BASE:-https://get.gofastskill.com}"

# "latest" is the stable track: /latest/<os>/<arch> redirects to /v/<version>/<file>.
get_release_tag() {
  if [ "$VERSION" = "latest" ] || [ -z "$VERSION" ]; then
    echo "Fetching latest release..."
    local location
    location=$(curl -fsS -o /dev/null -w '%{redirect_url}' "$SITE/latest/macos/arm64")
    VERSION=$(printf '%s\n' "$location" | sed -n 's#^.*/v/\([^/]*\)/.*#\1#p')
    if [ -z "$VERSION" ]; then
      echo "Error: could not resolve the latest version from $SITE/latest/macos/arm64"
      exit 1
    fi
  else
    VERSION="${VERSION#v}"
  fi
  RELEASE_TAG="v$VERSION"

  if ! CHECKSUMS=$(curl -fsSL "$SITE/v/$VERSION/checksums.txt"); then
    echo "Error: $SITE has no checksums for $VERSION"
    exit 1
  fi

  echo "Using release: $RELEASE_TAG"
  echo "Version: $VERSION"
}

asset_url_by_name() {
  local name="$1"
  echo "$SITE/v/${VERSION}/${name}"
}

# The sha256 that checksums.txt lists for the file, or an error when it lists none.
asset_sha_by_name() {
  local name="$1"
  local sha
  sha=$(printf '%s\n' "$CHECKSUMS" | awk -v n="$name" '$2 == n || $2 == "*" n { print $1; exit }')
  if [ -z "$sha" ]; then
    echo "Error: $VERSION has no file named $name" >&2
    exit 1
  fi
  echo "$sha"
}

ensure_asset_present() {
  local asset_name="$1"
  local asset_url="$2"

  if [ -z "$asset_url" ] || [ "$asset_url" = "null" ]; then
    echo "Error: required asset is missing from release: $asset_name"
    exit 1
  fi
}

emit_formula() {
  cat > "$FORMULA_FILE" <<FORMULA_EOF
# typed: false
# frozen_string_literal: true

class ${FORMULA_CLASS} < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://gofastskill.com"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "${MACOS_ARM_ASSET_URL}"
      sha256 "${MACOS_ARM_SHA256}"
    end

    on_intel do
      url "${MACOS_INTEL_ASSET_URL}"
      sha256 "${MACOS_INTEL_SHA256}"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      # Detect glibc version to choose appropriate binary
      # glibc >= 2.38: use gnu binary for full features
      # glibc < 2.38 or musl-based (Alpine): use musl binary for compatibility
      glibc_version = begin
        \`ldd --version 2>&1\`.lines.first.to_s[/(\d+\.\d+)/].to_f
      rescue
        0
      end

      if glibc_version >= 2.38
        url "${LINUX_GNU_ASSET_URL}"
        sha256 "${LINUX_GNU_SHA256}"
      else
        url "${LINUX_MUSL_ASSET_URL}"
        sha256 "${LINUX_MUSL_SHA256}"
      end
    end
  end

  def install
    bin.install "${BINARY_NAME}"
  end

  test do
    system bin/"${BINARY_NAME}", "--version"
  end
end
FORMULA_EOF
}

main() {
  parse_args "$@"

  require_cmd curl "Install curl"

  get_release_tag

  LINUX_GNU_ASSET_URL=$(asset_url_by_name "$LINUX_GNU_ASSET_NAME")
  LINUX_MUSL_ASSET_URL=$(asset_url_by_name "$LINUX_MUSL_ASSET_NAME")
  MACOS_ARM_ASSET_URL=$(asset_url_by_name "$MACOS_ARM_ASSET_NAME")
  MACOS_INTEL_ASSET_URL=$(asset_url_by_name "$MACOS_INTEL_ASSET_NAME")

  ensure_asset_present "$LINUX_GNU_ASSET_NAME" "$LINUX_GNU_ASSET_URL"
  ensure_asset_present "$LINUX_MUSL_ASSET_NAME" "$LINUX_MUSL_ASSET_URL"
  ensure_asset_present "$MACOS_ARM_ASSET_NAME" "$MACOS_ARM_ASSET_URL"
  ensure_asset_present "$MACOS_INTEL_ASSET_NAME" "$MACOS_INTEL_ASSET_URL"

  LINUX_GNU_SHA256=$(asset_sha_by_name "$LINUX_GNU_ASSET_NAME")
  LINUX_MUSL_SHA256=$(asset_sha_by_name "$LINUX_MUSL_ASSET_NAME")
  MACOS_ARM_SHA256=$(asset_sha_by_name "$MACOS_ARM_ASSET_NAME")
  MACOS_INTEL_SHA256=$(asset_sha_by_name "$MACOS_INTEL_ASSET_NAME")

  emit_formula

  echo "✅ Formula generated: $FORMULA_FILE"
  echo "Version: $VERSION"
}

main "$@"
