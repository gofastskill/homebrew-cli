# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.99/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "0a13d4b67939a215df797b435ccd38d9dfd14cd1c41f5de0efd9afe1c46b318c"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.99/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "db3320b0fb52280edd7466366fe78936fceee5dc2cc41f5cabd0e275f9252cc4"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.99/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "c1ef43072e4a86032b1643500a8742f30e8b1f435474eda6786f25c3e5fb6289"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.99/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "9ec877e1d4d40284c65856bfddbe9d488c5d69c369ce9fc791103a5fca82e0a3"
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
