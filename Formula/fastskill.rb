# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.232/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "66fb10c87f61e95d77907d2d2a610281a95d2c5afb4b8f05c7cc83ea9f216fab"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.232/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "479ae6337c9e3ae8a5d23a6d00aa93fe1c3f89114646f01c11df2ef3c8768007"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.232/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "e68387a8b676df748bc8a660ee492b3331f00e96451c9b3a52a7bfb098e8e997"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.232/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "e39a700fb852a2de67c54c197c2e692af6493a4a1d6fda8204c48fe150f57d28"
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
