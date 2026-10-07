# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.265/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "37ee5e4417b7bf74ecf55ddc58b4a915081895888b8b350bb83bd63177dabbe2"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.265/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "2553b39c699403b53b415cadfc0a8169ff22eb81ac9a859732931c256793d597"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.265/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "e8e1bec6bd286a13d3ad52c58c95bb9352e0a805f4b5f8b4b306cdbfa9e2a9c8"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.265/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "8480dcddbec60850e6b4e722c96ec48e4f6fb64ca5f8f16f51fe786545e6fb36"
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
