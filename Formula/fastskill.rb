# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.179/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "a982f83fac1b92dfc538128d0ec9844ecc95194e5cde97d3216cb8733a687467"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.179/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "db4d8b3b0705399492ab4a895726825fc477cbdfdb1486fe09f8992d7e64af41"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.179/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "3b86c3b55a29cee6fc9bd5037502fbcf01495cc79a56e7c809bac550d2d30c5f"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.179/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "4a559c05d5be983b330ea8cdc16d25a25ec498f7ca015025f0b42f41dbeba331"
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
