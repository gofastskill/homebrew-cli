# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.95/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "15aa9174ed7b61f4ed91e21cfd0ef6e82dd07ff1a1dbaf08be85c5a6584c4227"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.95/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "2930346829248d39699bdc3be53b1c64ebe6a01760506f376c2884b861ea9442"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.95/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "1d2a91e14ac03656bbf2a78b26e7a757828edd39ecb4c53eed1d0d4cefbbaf6b"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.95/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "e3b301647e3cd465c7cf7582b7f0cb13d4930e1962f38a8a12a748f1c96ed6dc"
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
