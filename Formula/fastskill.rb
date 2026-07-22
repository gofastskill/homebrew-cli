# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.149/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "d999adee6eb44184fcd33af3db7bf3043dbf3bc78f69119c000a3b549fb8e48c"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.149/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "90f6b152640c01a7d1a7bd0880a39ab3e3334f4bf0771c2968d6ed55f5616d26"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.149/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "62fcef3ba37412424a834d674834baade1851fe64978b2dbfbf176f6bc239e65"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.149/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "55c5ebab9077e0abe8e5b3114c5eafff58483d3b0a5eb4652ac8c7c4df532894"
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
