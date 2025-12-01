# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.7.14"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.7.14/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "ab4a1791e08f4a144eaadef83aab4e312a5fee0bd2a169880ca85966f6f730b4"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.7.14/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "1f0ccae7a9a6f8f027be0c251692eaf5fc2b1c9a543d527b683841e4bd2a6ca6"
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
