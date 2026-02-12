# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.64"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.64/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "7834d3611d1f34de2a5207cdc73945b024a1fbce5554dec473424a986ac2bad6"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.64/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "8049a4af6558f9c146433603bd2c2004d5a7b72c09a64a94aa6feff6d55923fb"
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
