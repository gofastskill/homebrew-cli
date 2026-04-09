# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.105/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "a436acb09d80acd20dc92a005ea4bead8935670464620b5ab5541d74b194f552"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.105/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "b1f8aadc8825cda8e45bf4c19197a6f084f0f5d7994af7fbff678e993df83e0c"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.105/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "172c6e252f8371a565614724c68f750ab550ba004e1752adc6d3b3c0d25dc79f"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.105/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "f8ed0bcbed483e47e52626049f3d43ef18b8ceabc8dd7c74e63fc528106f3353"
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
