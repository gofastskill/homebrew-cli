# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.249/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "4960481a95ef2e4cde78b327617f9feb254edefa65061dde32281aa323f3605d"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.249/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "1c5d703dac33a200cfbad17d09ed2856ffcfa59164855bbfcce6e62d340ae49c"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.249/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "d78e0d3b957db4a119547fc6b4339fc313c8c52c3241d776683f327dc6dc4809"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.249/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "7aee0cda68fb093c867f9b2a9b4c2405230b39730d78d8d9949fd052167f4b1a"
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
