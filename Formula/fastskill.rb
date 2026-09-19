# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.240/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "34fda0ddf6e02e8f14a8c3685e1fa160a65d5c363b5941b9a2499df109e21336"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.240/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "eda0dfe40613ba5973e97ac2db143388f783a54d0720f3e62a8ca118485fdcc9"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.240/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "689d10ad356848cec239eb05c3829cc1ce30df6504c23241f514ca2a10399c51"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.240/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "65b2dd4f2a2d13a7d9b878cbcdb5e6683423686dc5d971febee53cd9153b107f"
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
