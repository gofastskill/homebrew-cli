# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.204/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "b6101bc638f818f40b31cd177f64da71a812dea1962e3d6eea50967393215235"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.204/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "025e3c565d00b4b8af3bca1c545791e6767fba4f8f86089149ef84c02308443e"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.204/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "5be04ce7a5889071f0530ee0b997a757c19325e92f143662ad15a292acf865ad"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.204/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "0b6d9bcf39078a4dba9437af06af87e86cfaa6a5b65887cf308f981c0f5c2bda"
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
