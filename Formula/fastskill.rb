# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.207/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "965bf9c050540d09d3b4ccbbcda4852d25ad530bf274534bfb7ec97035e6e6ce"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.207/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "50135f6d298a5fa2db34217dc6244e1c041d7713f32918208182bf511ed9d7f6"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.207/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "4f77be58f2f5fc8be773b38c9ddf6794a1e8aac4b0901c520d31f9f9b7fb1912"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.207/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "786a9bbfd835f0fe9881980f23f2930f16f768cdd29ee7cee3ed3f1e20f9ed74"
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
