# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.163/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "419cf7f56b37be852658d49ea0d2135319e85871f860626382811cdc2714ae33"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.163/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "a11d0031263d31349c136151c31f8c28aada32e8453e6522636d3fbc1bb0b745"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.163/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "85a20c98841c61b33438e2d24b9dc4aa5a676885cdad2302f7813335c18da68e"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.163/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "3b8a6ff20893a65dd53e525fa2fe679ae6347c60e44d5778bded721f8ce3f75b"
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
