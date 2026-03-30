# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.98/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "93a46e60a57d6f7e3161c0f81c0d5a6e3f99a9e54281258a03d083d6d47de14c"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.98/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "84cb116673bc56602521d5b1bc71d3abdfdd135c386a600a5ff0e7124fc970c7"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.98/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "473a01e725d7e707d5e389e2fad810feef7d0a5a496146efa7a9f11577de1568"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.98/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "9864b0b65286b0ff67ecbccaaa2a39396f7f923dec92424c10df88a9b716c6fb"
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
