# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.43"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.43/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "67bf9de3afc7df8415aa63d212c218522e3d9bb0f1bc5efe08c76fb00b2ddd49"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.43/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "c99cf376aae2fdcebc22551135b0440edf2416a83e480b0a3656effb458cd033"
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
