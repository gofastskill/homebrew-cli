# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.40"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.40/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "1c8d2f87f5e4c38ee8b2d0080d37943b7807717bae0fa7d94059c0d53004dd39"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.40/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "8333747e632a9c0a1d4e7f7864cb01e82e4929e1f283a8e3b989102b8a7f29a1"
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
