# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.257/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "41a9b29062df5dc93341941087ff8f5f8d27e6a0fc82ff225453575e70066a57"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.257/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "642245d1afd68ffccda8378e0a0c2b9fb616e5ef75293ac3346b88c6de2e8a7e"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.257/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "e3998353640b9205684fa614f50c30e1f5508049453235a21d9bb5c3b9010f73"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.257/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "9c1c0f0a0e682888a86525a2370b76c227a310f77ba9868b3a78ad492095510b"
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
