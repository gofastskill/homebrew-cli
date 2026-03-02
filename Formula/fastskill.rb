# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.87/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "bbb5f38ffd72b5acd048d82cee3c85510256e29250dbf2f1898b07a12b85300d"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.87/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "911d10904c5d0fca8253b859ad1754e5095f398376ce5d7dc60c39892355baf4"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.87/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "11d654b1935660ed49e87673fffb8bfd9b1bf3ed4fbbf86e83034b33f658d77f"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.87/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "9aa15f24eb9a7c0d09c5ea277f08194a6862b2129199a46469d7f9bcc551d85d"
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
