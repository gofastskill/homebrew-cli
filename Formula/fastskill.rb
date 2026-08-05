# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.155/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "212537a7fa35e5f0fc01b812ad81465197526cb25d2c903a0c528de3f0ac2015"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.155/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "a747a831af6841f2b8fc9890cc6dbce8472869a7d34978ef363267caf4f89f51"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.155/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "40e5accb7100103001ccaa4be3930a5b0105fc62df992b587a3355a99bbe8f90"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.155/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "bc688d7173f499ea29b5300c5c29153d7f3be623ff18f0f7db8bc275db175562"
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
