# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.272/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "f6f8db6575f5c30453c62c0e1c3510840d1b15b4a3dd8f42696d0beab9b6eda2"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.272/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "9d8f8d08597f9a07a85e1cd8d8e5cdbe4f3590e3ea6a516fc0ea120c3c6be164"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.272/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "458dc8e199c53827c89f2e42f058d4201ef583d65c41eed2d32c5d639f2435b3"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.272/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "07eb8a69e8f7fa23522bfa2573f35103ed9be2697709a3f8f37a4856786b1ee6"
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
