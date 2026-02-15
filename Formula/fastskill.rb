# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.74"
  license "Apache-2.0"

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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.74/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "6e86aca8670ba9317f1d19d61790fb795540ca8282d70bed012e02f37bd79dd5"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.74/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "ec5c5dffb125bfefcb2d076c1667324543a45adbea82ba2674aee54b3fe015fa"
      end
    end
  end

  def install
    bin.install "fastskill"
  end

  test do
    system "#{bin}/fastskill", "--version"
  end
end
