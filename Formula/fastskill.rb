# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.134/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "a6c5ff297bdd945e61699618ed8aad1bcb82e0c001863e73dc1d3f3638b6a85a"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.134/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "7cb2241a675570d7c9ec97b10433f0d87d3e1f7783b7a0942017a72b235d2829"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.134/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "bb7e15550a50fdc65da592968df8c390c8d54752e879139eb04546d62d534f58"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.134/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "09de8656f5734699a714da298a2debb2799b7ba0bf14764f794cf9cd1e355aab"
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
