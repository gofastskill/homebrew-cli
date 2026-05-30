# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.127/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "b4eb0743784a334029188a15a2d1270f24494a52b7f8f9630165e5026a81a3dc"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.127/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "592065297e7df41575cc47fa3a22c02db839db122177ffaf393b94d7ba22febc"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.127/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "7ff6eeb32885cfb0a8f4b1bd01dc5b3b0916244526551f7c9ed67a44cfa2c721"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.127/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "67d0be16f6e637894b3958c77be964740c1fd886be4fe986fcf44ab71f4c8193"
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
