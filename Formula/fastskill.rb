# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.266/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "200f90864b732a3cf06f94d6b7bcf3a29de5f80b7632d6815377646f1dc78296"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.266/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "0f3e293c45af616da5f61613385335969f4390f5e40825cd09f91bce801c6902"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.266/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "911ed0c8ab7bce0e982c7260bfb36240e8a033f3ac4934a9d2ebde2a2df02edc"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.266/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "84cb07f5b84a48e8ca8bdb19d87ec49e654e7de7d5f8283f149c4bcd6e629602"
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
