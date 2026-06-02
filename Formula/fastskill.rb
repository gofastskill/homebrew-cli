# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.128/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "e7cef9eab24e58d1a2ef5824576277d7cbe664a2390bdc09ad7a52a2fa2eccc7"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.128/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "2d9c83b4656fd87bf3964b98024392ed04562197e185d4665d5a7d9218c38795"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.128/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "46c1666c82e5efa065d6967cdfe34f2c10d39b148ed85200b8a9d1a98442cc50"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.128/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "43f4c4fa77996259257e69c5de98630381dd63f45a08a147557a3af928c2649f"
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
