# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.269/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "8210ede16a2ab919e4b962557a7f4d8f64a0c7d9c9a5c0b8231d9e6f20821e0b"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.269/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "8c2ca9aa396ea560cd64fd3c0ad37d46b24f4f5574340db02f0873bbeebd0cfb"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.269/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "7cde914d5d3eb9cbb8238bbd80f14288066e63a6ec13c349b28e76e883a15860"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.269/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "835bdbffe159ad6f78712df1a75c28002dabf67a64e8210e14b61eac08d4d0dc"
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
