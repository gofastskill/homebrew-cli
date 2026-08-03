# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.153/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "91c7355afe69fdb019f02d3855b8da39f8760351a44e0918e8f50551f8c91e40"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.153/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "9d6857c94e7d12cb16339c24b066b228f855e64ea354cb1b32490467150eef31"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.153/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "d4c9d184d8787eb154dd53ff1aa09adbbb49eec5e2205303428240c9958cb3dd"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.153/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "1cd2254cd9ef2a809bf3a0ded9394ddc3781c0500b8557f317bef1d81d2fc8b8"
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
