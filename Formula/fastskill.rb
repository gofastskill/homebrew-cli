# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.208/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "3dc46ee8b5d23476fd95ceed13ccd99b4ccf2a0ec323828c33ee93b3299a5c6b"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.208/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "d2db911d068774a7027587d239fc1d32b6d4b1eb8b44a136a9219af41532adb2"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.208/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "378424c40a1b9e96ce109d803d25096814d7043496f94c80a62940e54cba00ed"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.208/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "9cf3c9290321b61ffdcde1454b96ddefdad6a364b728420d52559c068b49b94c"
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
