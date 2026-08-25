# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.196/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "8ef8d49195edb9defe4e75034d6afb58dfcc4963f16e8fa7c6174615fe5e3937"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.196/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "c697c742a87142aa24eb7797b2d97117a3e4b1913778ff10ee5b49bfef7f94bd"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.196/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "7c3840e7816863e003a1811dd3f4398cb3c4b4349fe177f6b7214432fc6ee770"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.196/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "e59f59b6d7a3d4cbc515ee3a193310a605d8e9c8eb2e50f992a8315d54e918fe"
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
