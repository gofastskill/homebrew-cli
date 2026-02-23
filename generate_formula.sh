#!/usr/bin/env bash
set -euo pipefail

# Auto-generated formula update script
# Usage: ./generate_formula.sh [--version VERSION]

APP_NAME="fastskill"
GITHUB_REPO="gofastskill/fastskill"
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

get_release_tag() {
  if [ "$VERSION" = "latest" ] || [ -z "$VERSION" ]; then
    echo "Fetching latest release..."
    RELEASE_TAG=$(gh release view --repo "$GITHUB_REPO" --json tagName -q .tagName)
    VERSION="${RELEASE_TAG#v}"
  else
    VERSION="${VERSION#v}"
    RELEASE_TAG="v$VERSION"
    if ! gh release view "$RELEASE_TAG" --repo "$GITHUB_REPO" >/dev/null 2>&1; then
      echo "Error: release tag $RELEASE_TAG was not found"
      exit 1
    fi
  fi

  echo "Using release: $RELEASE_TAG"
  echo "Version: $VERSION"
}

asset_url_by_name() {
  local name="$1"
  echo "$RELEASE_DATA" | jq -r --arg name "$name" '.assets[] | select(.name == $name) | .browser_download_url' | head -1
}

asset_digest_by_name() {
  local name="$1"
  echo "$RELEASE_DATA" | jq -r --arg name "$name" '.assets[] | select(.name == $name) | .digest' | head -1
}

calc_sha256() {
  local file="$1"
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$file" | awk '{print $1}'
  else
    shasum -a 256 "$file" | awk '{print $1}'
  fi
}

asset_sha_by_name() {
  local name="$1"
  local url="$2"
  local digest
  digest=$(asset_digest_by_name "$name")

  if [ -n "$digest" ] && [ "$digest" != "null" ] && [[ "$digest" == sha256:* ]]; then
    echo "${digest#sha256:}"
    return
  fi

  echo "Digest missing for $name, falling back to local SHA256 computation"
  local tmp_file
  tmp_file=$(mktemp)
  curl -fsSL "$url" -o "$tmp_file"
  calc_sha256 "$tmp_file"
  rm -f "$tmp_file"
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
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/${GITHUB_REPO}"
  version "${VERSION}"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "${MACOS_ARM_ASSET_URL}"
      sha256 "${MACOS_ARM_SHA256}"
    elsif Hardware::CPU.intel?
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
    system "#{bin}/${BINARY_NAME}", "--version"
  end
end
FORMULA_EOF
}

main() {
  parse_args "$@"

  require_cmd gh "Install gh from https://cli.github.com/"
  require_cmd jq "Install jq from https://jqlang.github.io/jq/"
  require_cmd curl "Install curl to enable checksum fallback"

  if ! gh auth status >/dev/null 2>&1; then
    echo "Error: GitHub CLI is not authenticated"
    echo "Please run: gh auth login"
    exit 1
  fi

  get_release_tag
  RELEASE_DATA=$(gh api "repos/$GITHUB_REPO/releases/tags/$RELEASE_TAG")

  LINUX_GNU_ASSET_URL=$(asset_url_by_name "$LINUX_GNU_ASSET_NAME")
  LINUX_MUSL_ASSET_URL=$(asset_url_by_name "$LINUX_MUSL_ASSET_NAME")
  MACOS_ARM_ASSET_URL=$(asset_url_by_name "$MACOS_ARM_ASSET_NAME")
  MACOS_INTEL_ASSET_URL=$(asset_url_by_name "$MACOS_INTEL_ASSET_NAME")

  ensure_asset_present "$LINUX_GNU_ASSET_NAME" "$LINUX_GNU_ASSET_URL"
  ensure_asset_present "$LINUX_MUSL_ASSET_NAME" "$LINUX_MUSL_ASSET_URL"
  ensure_asset_present "$MACOS_ARM_ASSET_NAME" "$MACOS_ARM_ASSET_URL"
  ensure_asset_present "$MACOS_INTEL_ASSET_NAME" "$MACOS_INTEL_ASSET_URL"

  LINUX_GNU_SHA256=$(asset_sha_by_name "$LINUX_GNU_ASSET_NAME" "$LINUX_GNU_ASSET_URL")
  LINUX_MUSL_SHA256=$(asset_sha_by_name "$LINUX_MUSL_ASSET_NAME" "$LINUX_MUSL_ASSET_URL")
  MACOS_ARM_SHA256=$(asset_sha_by_name "$MACOS_ARM_ASSET_NAME" "$MACOS_ARM_ASSET_URL")
  MACOS_INTEL_SHA256=$(asset_sha_by_name "$MACOS_INTEL_ASSET_NAME" "$MACOS_INTEL_ASSET_URL")

  emit_formula

  echo "✅ Formula generated: $FORMULA_FILE"
  echo "Version: $VERSION"
}

main "$@"
