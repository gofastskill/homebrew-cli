# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.71"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.71/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "4d2cf08a6fdc1a9c0dd76afa5eac518dde912a05a576097d5b0bbee6b5106bda"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.71/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "6b847dd316873a432a4c19688f1071f1e017866b66b32b11212bec85056c750d"
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
