# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.140/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "93e1a815322bcc07bf60a220b49a8996733c0f59687c5d102253ef950781957c"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.140/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "c7375b05ade1331c61e6df337761e0991cedd61eeeb5b4dc810967bbee412eda"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.140/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "e3cde2aefb16d8a12b7b48c6b03e1daaa41f13b2e2b4dbd6f1cf5c6db4a3b599"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.140/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "643190e2b46e68c71136bf3cee04d2bde8cef899e0968b758f44ee921e1a5000"
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
