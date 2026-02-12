# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.66"
  license "Apache-2.0"

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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.66/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "29bf9d50ff495ee7faf983c5e9225dc245ef0bf8e41aa4f2d2093859b3c6d81c"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.66/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "ad8bf37f4fdb85614ec09b68fa790ab25c892e13d9bf5cbe7130a4c792b851a1"
      end
    end
  end

  def install
    bin.install "fastskill"
  end

  test do
    system "#{bin}/fastskill", "--version"
  end
end
