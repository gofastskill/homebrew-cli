# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.191/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "1e98291de2faaca94b8fcbe483367f57b7c09dd30dfb3970af9eb8dde7259948"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.191/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "59528dffb15a25d6a64cb903add8428554e6cfd4929e0eb4693486c12c1c3a34"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.191/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "9a78ff6ecff7eb6f3b7c07da5d7156cb3d9c8e11a991db760f5bde8b8e7ed3e9"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.191/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "3ca31518f850c469cc5ab8dbf61db7c53f5918694efd16aa6b7d6c488a2df135"
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
