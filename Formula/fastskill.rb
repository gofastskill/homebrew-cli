# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.174/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "7f5d8a9731beaaa94aa980f41d6fc33790bd7ea5e0262514acba67f3b05e5a23"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.174/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "3b71275896cc7458f08ea7ac7ae46a56bc26513c2d8937aa99d03ae3cc1b3a6d"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.174/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "4d6a436ee722a855088f3c219ceee377d05d9114376eaeaa55a01dd4faf9f9ac"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.174/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "64c3bd90f7a7a16ee6fb2e96d30ba45c5e515130c98dec7eac01c9b77dd994cc"
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
