# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.253/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "32a2638c5fda5734ff060afc76b370cb7ce5b9b805d081760537ee68696a7090"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.253/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "c77e9dae73dd3ec72560474f5dfba5e12a6ef89a042a0b0f070e960f35c213fb"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.253/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "4a52e6912aa4bb0fdf8b6db14903eac4a6bc0a01c6ae82435ee7dde3ee576e1c"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.253/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "278be47825f3568a78cfd917c10dc01443700b5f0bd806223077aaba7fe955a3"
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
