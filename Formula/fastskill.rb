# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.129/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "f6893d932b4e5e97949b6c372af1f0059f28eda6d325e4ff1e83aff98fd5a962"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.129/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "ce9d6b8983e1d0c40a51983d827b12ab771687d904b374b0b0fe7f5cbd548983"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.129/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "ebe2c9333168aad512f3734486c0ef16bbf7ee88bd2d6cf6c3beb7c0ffd7088c"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.129/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "5e0086fc4ca0f654e47129b69e34bb40c82358ad7ce8c6ffa1ae6ee2c579bb35"
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
