# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.234/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "4ef11158c27941982f0ff4ae8eae562d805ebde86667f8d20c300bde8bbaeb10"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.234/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "17fed31a4d5b4b9b3d7da5712e8794138955f24e35394cd5142ffaf8409711e9"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.234/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "f10c1de6cb4d8a749ceefbe6ff06400b48cc009c3e288d0c24f1b1cb5b146da8"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.234/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "7a1fb1a9d2c4b1c7a39edf17f6014925d7eff9c5d3b10e9de164b40b3b0c3900"
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
