# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.35"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.35/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "cd68b1ecff58c37fadd068315d4301a1000bce5fd07b803f2514c3ab2dcd7c36"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.35/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "d5e715c1a6ff943c92cdc259b1cbe2335eacf56e5d3c67b1d39e687bdf047724"
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
