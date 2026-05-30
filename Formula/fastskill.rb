# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.126/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "8dd674590c4f38b1a1944ba8c0c7ca080c1a7a92368ee6d2055de6663a253672"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.126/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "3d1a8f5fc7ab1051f3c0bc31a3bfd664bf707a5db693491edea5537d0520f1e7"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.126/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "4bcd7ea30f910834e4c41f846d67403313a93862049ac72cd9ac131d2a26bca8"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.126/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "8f583f0f8e491eebab75c0dc225403d80b6ba5dc6a6949e3a736795d89a6488a"
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
