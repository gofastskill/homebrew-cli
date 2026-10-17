# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.274/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "c78d9db429f97fb6e9a6cf0b5c99737400858c810297b77fc04df312dccb6a7e"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.274/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "4ade8b364b6c1dbd83e2cb16ce36488e406b30f90ca1659d822e15aaefc3bc16"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.274/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "4f4a8e610cdde232899016e9673326babd9e24148a79599f14ff550dcc0f6d3b"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.274/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "bed95068de7b3d557435b14a37dabb1ddd742e6a6a4949ebc145058e46f99a41"
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
