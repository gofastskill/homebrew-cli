# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.192/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "34974493c41a514f5087d3a3bc8be0a47f790f9f2c91c38c398721c79c589f65"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.192/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "35b10756a9146ff06e99da1e91bfe1a65291285716baf192efb5921b205c9d96"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.192/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "2cdd8b313f76da71d35ef47c3eb7ad445690ad4ec93deff85e0527e9e23f9fcc"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.192/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "6231993c4c0f66a6d450a9498cb20c603f7001c88dbd566e8f8669393cab98bf"
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
