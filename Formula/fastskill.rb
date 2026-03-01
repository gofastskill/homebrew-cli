# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.84/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "96aa95a90fb839bd481b62ea9c4e3fecbeea9f014374a63c8fb4a0c3e748bfd0"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.84/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "0d4629f6d11e23a21cb731c9ec33755943357382381106d69c1ffcf906061d97"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.84/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "0a719242a62be677b78e4b86a86a8b51816e46dc7c3ca4fff8466f4d20d9768a"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.84/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "cf14de868c450cbec0e17b33c2ae53322b241f78f8de20c948b2e55e2e2fbcff"
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
