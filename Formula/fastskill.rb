# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.202/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "3bd5387c450f1a855f029cce0fec305c54c4f7882cc4e5b655ef8921ba644105"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.202/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "5fbfe2e9b3e0af0226e77efe696574a5cc36bc85497dc80f0bebcac5e22b5e58"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.202/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "e56f55d8f721ec215fd6adfadeb1fda61959a2803f15aa203455bda4ee4b405d"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.202/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "2c938bea1bdb186c96db0fe2a690c16e0beb2add3bebf49f16b0d3d8db0054bf"
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
