# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.96/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "c4d39f2566b40f19b3660c5210eb3475c7b725a392686f8e5c7b44dc5659b9aa"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.96/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "36e813f7a3a86ffa6ba2b9d3d7f02db2275b7ced90cd1b7c47dbd67a18382e4c"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.96/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "65195565ba37d4aea24675baa9f2f9f95ad48a324a6d34609e272e153e9a83bc"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.96/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "d2eca58edf3a77a65eece5ba0547667a64fa43a3acfbaf71b2d9557ce2cf242c"
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
