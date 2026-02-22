# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.75"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.75/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "476ddc4988d8653c8568810ce7fb587c9f8e294fdd60dc8773f66ba2c2c194cf"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.75/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "ba828b65c6ff1f015fec80609814a3901160ae805e3a62e8ca99ee36c61a0718"
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
