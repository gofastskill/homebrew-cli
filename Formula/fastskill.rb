# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.145/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "363dec7ceea6f2e75407af49265eaef2adce6fa77398786e24d7600aa4fa958d"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.145/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "b4da03c46a51b0692bf5451086f70fe2652be3db36a739fbd1f70d7d9c32419f"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.145/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "bc1ded1d25a9c70384dc0cf4fed312acb8b2307cea92501f300faa1b27f5ebd4"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.145/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "91e11d73c5e0698bf4f2564043feb5545e31bac26c36ff564827a031bfb712bd"
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
