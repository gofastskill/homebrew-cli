# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.138/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "3d12b482145d59df0d6ccf4ec6170518025d819d017e6b2c98f75d2f3a050f35"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.138/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "f88390cfd7cafda4d593738795f98261e4967ce9c6cb0cd6824c0fa8cafec715"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.138/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "f338ad827bd1ced6c16e2bf7e76d23f02c103104ef2a9b9b73ad0d3455325b7b"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.138/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "9d972580e56d6d9a6ec387ac423a3075e848e99e3edfb5021f05450c47924790"
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
