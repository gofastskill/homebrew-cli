# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.264/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "8df615f0ac954b2560612b1f117d92dc03fb1a9cdc169ed672f7576cb6251ce5"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.264/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "38c15234eba7d3796d25ce2819370c53c49599a3f4a523f2867245617df25c0a"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.264/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "c50498e4e5fb8dc0a930a9503cfe8fd5d645462f4d6cb1e9eb1142014cd6edf6"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.264/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "26e2cccfae648c42b1ddee107cbf24ff9ad814a7e88eb1a85873517f75571075"
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
