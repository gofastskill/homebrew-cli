# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.245/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "8c0bf7b154995779a2cbcf67c4f0732fb9a6e015472e9dfe8ea37d096e030850"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.245/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "11d6ea41e41ae5639570c68396a06a01ba658de6d892434e08a958b8c24e1467"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.245/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "3a4a0be994bd1195c6ef5aa2f69e0bf71954c049c779c29f69daf382f6d4d959"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.245/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "e8b42cfd29a6f47a71877bfbf0d742b392c5aa9def6138807bf464109be51fe8"
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
