# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.61"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.61/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "b59e49cd99bba48fa29846837f0ea4c52ffa2e36db498aec8465185ce9a7ceae"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.61/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "fd59275a3a9794394559f8bb90ffcaedb8f7d3aea0f9b37d517507512db5b447"
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
