# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.227/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "6cf0884f21baba92e3e8e7981c8d332031a0a91609b091db66868fbd1744f616"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.227/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "92980ca11b4d4d69bdbd15791bae740c51d665ed8c998427f041b7f6a3621d13"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.227/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "57273bf65d36d8d61e4fa532e7dfa57178d488b18da1c065d559d7c8c8506d1d"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.227/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "f2dffad7a0eb6d73ff9801b2e48b6c9c4707ea269f8c0a1abf577e19fe9babd4"
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
