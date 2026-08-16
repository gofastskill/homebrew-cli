# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.164/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "8ac108607b63f1b135daecd6066d98be239cf41b18ab199ef6967ce1b7e6e5d5"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.164/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "c9bbed1f16c67bf29bf46e1208e757f5044e7ead3231a304b3f774bac4c04690"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.164/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "0350bacab8ccb0773c13084428c8aba1d640efb63f87bf2abd1b30f3a0f4f54e"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.164/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "d6c8afd79808334d2b961d8b6027901bac54d452b49cfdf3970ecbc97de64ead"
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
