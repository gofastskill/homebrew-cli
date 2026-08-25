# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.197/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "4e12a7a478fb83bfa0ffb3cc01172f54d11a0642c5b8f02523a7fd7b304dd748"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.197/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "41e82baa0fb5236d663d378e03c2be3b20f7620cae173a9598d2b6244c39ca5a"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.197/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "5f0fc97cab9076e675fced201a6b6c70d9041904a2fe156683e4d3a7bc871107"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.197/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "2e447a3f1353c068b8eb6247fef10866b6c024c70d338bd0160f2e6723e39ed4"
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
