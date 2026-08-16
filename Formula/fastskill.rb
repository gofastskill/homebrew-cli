# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.169/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "a5cac6850f60b46a079ca8139e5e4326b803add108e94b62e8bdcc278f65a67c"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.169/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "d7f6d1049e224f724d9e33de32d86144a8ad578adc732585d934fb5075f5ac43"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.169/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "ce66269d8a827d818003ff0107369e85b4eb217ad112bc5bbddc4d766cfbd805"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.169/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "e4d9f7616d80a5f956f3f1f96e98f5c421bd99330d3d021ae366f03ac23c3050"
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
