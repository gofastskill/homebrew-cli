# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.117/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "4fb36744b0c92c16d08694b07929998aeda46c90905099bac2ea201ca6d9501b"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.117/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "4c2e9718787968d2ccf01ce834fc65a296f47d84cb95406b1f2e8ae2f33598e0"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.117/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "de12fe99875f3a60551a72dac0cce517ad09153d23c054406aa03723214a379a"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.117/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "50de2a9cae1c844aef95b9298f767ced9c5c7077eaab57ad739169d1fb80a98e"
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
