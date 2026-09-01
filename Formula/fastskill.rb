# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.210/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "34a7c95987a74f9ba58cb085efe6b8ee6a0d9436d9832ecacba6a09341953f98"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.210/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "4b6ba9be1910bc52f84a2059e4cb72ed0626e7eb9e375820a114840232b71ba1"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.210/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "20215d7071f453a73965913e301bdb2e4c51ff770efe97ddf810f55e501e1f00"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.210/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "c52ec7693eedde81576399f6e08d6c8762dc2633acedba5d4ae6b33d9fbc16f2"
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
