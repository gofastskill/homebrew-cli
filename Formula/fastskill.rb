# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.183/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "a9f94b96c2bcfd767afeffef92b3f0687adb328c6ce3695de2cd865f50c1bf46"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.183/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "4192ed119fae2f0b8d12eeb33b77017f2f53e2369cb199699a377868139fa8fe"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.183/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "b17122e03f5d11243be2f471e11f9d27c7835b5f384fd6e9fad65941ce8f91a0"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.183/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "c803bf5a068618543ef1f27b0bb8cf869fb57241ba42abb3da6c17e3406ad373"
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
