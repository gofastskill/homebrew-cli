# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.219/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "4b26fdca99dafafccbe2b2ce1949273748f051e8ed9b1b7afc7c6ca56d564584"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.219/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "028a28803a1b68453035711c8768f39217a1f974a684c6e2c4c757dbbb390077"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.219/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "32ce8aa2e33a7828f8944a4cc6d4cd99496a3a57ff202d58210083c528ff563f"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.219/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "d064269e9318b8f0f5fac107efbc9006cfba62df2a94317b54d2e42c31fb6fdc"
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
