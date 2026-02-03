# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.17"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.17/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "7ff08b8f69f5dd687ef7a191bc1d47b44fad77e93bc3b425bfb953435d477304"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.17/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "930c1a2662b1b8102233d081ae035d1d1ee81883b1a0a8e03fc7120232502b3d"
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
