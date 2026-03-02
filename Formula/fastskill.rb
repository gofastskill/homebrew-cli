# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.88/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "04739f0915e3e6cbf721834c3842da449a39c81c24ebb9c605a55283dd0dd84d"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.88/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "e9aa75406dd72d9a98ccc92c539a18c1840359ab8e214e77afb169755af3543e"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.88/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "f78d81206071385cf30f081b4778467c7a895a9159dd26d0c8bfe3e26d12f5a5"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.88/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "c182bf35c28cb4fb1e7f9bdf17d5d56c53df5d4c66819a9a9ce8858bc083c2bb"
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
