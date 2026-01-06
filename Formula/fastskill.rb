# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.5"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.5/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "f0b71620d67d37a8e4f9b62cbebb1ff6598e9a81223d19cdfd76c912a08001d7"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.5/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "e437484690849ef85d0ec1530facba0020757abecb09f3c528d547876397b8bb"
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
