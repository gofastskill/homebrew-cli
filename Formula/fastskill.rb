# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.237/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "05b6cb7619b1019f6947709e62edcab9b5402cdc56329c5c685f393b8fdcb92a"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.237/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "f1d8b19304ef654c0e0970bfaaeffde0f3ce7973b10b185a8b3f93ce470cb822"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.237/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "8061b175ad337eecc36c64ec4b26ef530ab880bcc02408b2ca321a828b240ab2"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.237/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "5c2f59009c02555fac5c79c194b2d1b58f25417764d118c61dfac86443ec296d"
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
