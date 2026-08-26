# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.203/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "1577e0f7c1fb39b70ca713f09932225ee67e0242398a0bb698a5f2858126d3fd"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.203/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "72714a21536160ce6c2f697341f5e8e0a6b6b8551f110e1e5e703c8ea4f6e4bb"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.203/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "bc060d7757b81ad96d8ae35c1479f8d62eeaf364d856856f9fd217ea69f22410"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.203/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "262774cafe54d27402bdc2146989a40c74fb16d843dddb15abcf0d8ba13ff8ba"
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
