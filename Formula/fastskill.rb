# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.205/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "f8d130ac6d5fcb652dfa1fe697ec46f140b181123407c25c4297c9aafb29537c"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.205/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "a2f6da399564d6150d649c88e5f890d306f8a59ead5e8ac715c402385f98d9f2"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.205/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "626d2439507489f526e6e9b835df065c5e287dac4a2724d4c5bfba9c9d9a2e84"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.205/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "b65442f9e3cf7b847819a6bf68e7bf77ddf8b09ac7ac0cdbd3cb96b5954b5562"
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
