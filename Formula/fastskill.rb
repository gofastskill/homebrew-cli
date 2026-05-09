# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.113/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "0e0b5143bb60bb330a7c8f1c78fef687ee1fab51d64d81e1e5539f18d03f42c2"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.113/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "30b07cd1ea8ed535d29d9160dc26131c5776f259bb25fc78f47946cd6ad753b4"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.113/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "c8bd2fc452655c4a0374eea796053f41255e05f88f88257a9e99e4414bdc434d"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.113/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "d27a694ceb35a785b2d31cd37b08feb7d806d081ddf02230a636304336d97d2e"
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
