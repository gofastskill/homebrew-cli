# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.84/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "00ae840639564d0affd9e79b31df18be2ba0770ea2d1e6ba380adce14f567dae"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.84/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "6b09a75090d64eb28ce62acb44feb6c88dfff819511229aafbab0f7031bb2fec"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.84/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "dab300f21af8072957f9c408a0d0ae86dd30ec416e5618965e8eef2d0c823bcd"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.84/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "9b6e766a9275048665e7fafae74157d578962cadc53610e042e83fa65ce45cb1"
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
