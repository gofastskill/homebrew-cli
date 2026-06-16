# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.137/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "16bba81a804dc331987a645625a6d9aed7a30688ec4c7c1326ca887087da3ff8"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.137/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "618b34db93dac3276b23cc27b04301376ea21d035dfd650526b4ded6b3736f91"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      # Detect glibc version to choose appropriate binary
      # glibc >= 2.38: use gnu binary for full features
      # glibc < 2.38 or musl-based (Alpine): use musl binary for compatibility
      glibc_version = begin
        `ldd --version 2>&1`.lines.first.to_s[/(\d+\.\d+)/].to_f
      rescue
        0
      end

      if glibc_version >= 2.38
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.137/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "f74b4bbe9b9267e786c87f8d9282b18ccb9078f088c79e30abc44bbb45b561ee"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.137/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "7ecebc6e30c8415f05341ec84891f1cfa3809a219d5c3390071ba88b91f7b40a"
      end
    end
  end

  def install
    bin.install "fastskill"
  end

  test do
    system bin/"fastskill", "--version"
  end
end
