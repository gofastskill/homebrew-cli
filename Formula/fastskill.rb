# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.114/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "47ec575bbef8ed62c6555ba991fbbf38f1000711ceb91bc2dcb8cec0efb53d5b"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.114/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "8025be653412666f8405eb8664716734d150cb24d7161a0901e6e234dc42459a"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.114/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "fbeb48eaea076a267d935a68228c66b1ee560fa889d2d757be1ef33b4371f76c"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.114/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "ff4cf0a89d65069cd497e597665819e71fd4f31bc566511716b949071e424e3b"
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
