# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.27"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.27/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "9fc587675f864557a74a2b80f40768572a3cb93783cbe961d23bfca7b012687e"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.27/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "e0cf3e46ee1f1d7b4f9f2e17f49ede4c0a7d498beff02e23b0d546eca0e8b8c0"
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
