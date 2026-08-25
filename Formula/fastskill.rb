# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.195/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "a5d48fb3c47a632964c5e96986abdf2e817de57f9033597096aa56a409fd8037"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.195/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "e6eb5bdf438719e74e06981bd95f0aab634d7e576a22f7359c268efa8893fb01"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.195/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "1795262cec36f78d0e7a8a736da7e9e7480f7edf1301d38f76dcee9ad8fbcc97"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.195/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "f4f0461aead86d5888b1ccae8e265f2d2448a06b1a0e8fc13ece801420f24d23"
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
