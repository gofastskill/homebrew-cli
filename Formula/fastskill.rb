# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.181/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "18adcb81d45a4402a7f631456d6e8b42cbc4f4ba19c58eff646fdd3878dd61cb"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.181/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "77550093651168df09202ebe22e74aa9c1a13de1a0d929b76a306183cd6d12d0"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.181/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "060a79f135f0244a02774356ed60498f76466fc20187db21980baa3c66325daa"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.181/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "8f8d259635a35cd25322c324daf6c27ae0a772daf344b58177ae96a12764000c"
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
