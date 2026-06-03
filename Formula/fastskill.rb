# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.130/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "5e1780fff99895510055b096417ee955524c22e554617c8b938f09a8bfdcb88b"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.130/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "9ed38a7762ff337909b9ba68e680469f723a5194e402013465690489b5d50689"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.130/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "82dbc0e2282a83b3c281213f6cd2681660e99f0fb07ae0557f8a0b626328ec48"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.130/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "c00f2f0faf2e6feb604c92b33a851970fa70baff7fd0b625e027d4262a3822aa"
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
