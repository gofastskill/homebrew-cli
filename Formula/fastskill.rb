# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.39"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.39/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "d1e125aeaf3c71dd55de4efd149e642971380983709009ef7a7708642346838e"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.39/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "86db45c04be47e5dc3415388668c164194a65097d1f96b9e9938f1b86151c6fe"
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
