# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.157/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "7d639474de79846f2a3b8d4d0fb70a80c5f178da08cdf4bc9ef999011ca01c17"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.157/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "2969a622a0e77bb9b8b5eda68bcb642a870a2b2cfdd659d6bb307a922214c5b8"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.157/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "b570e0bcd284c0e01d3d5344195125fc0cdc859afbb52aabac95cfb7739902c6"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.157/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "42c4bc130527c8c2ca7dca63de78143c986bb517005b6760cfc1af1942207dfe"
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
