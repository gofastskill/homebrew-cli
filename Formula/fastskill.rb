# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.238/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "cb5ec61dfbb57595ba142bd84a94e2ff06aea0b674ea4b5b959ea32740a4db33"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.238/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "4a75f07801b06647f40dee479aeeb4207ae0bb361145dc5bb07f3f26bff1f917"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.238/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "d03e97978df903f87c9e9678488ab57836f1ecbe79b15d2f44535744a93823ae"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.238/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "676fceefc4e25592ba116fdde3c5677c3d5e64a7041a7cf7ad392f14346bceb0"
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
