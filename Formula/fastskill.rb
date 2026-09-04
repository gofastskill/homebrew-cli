# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.215/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "8719c8a3474d2e34a50d0f6be8a7c89be10a732a05559af0c75b9598d6a29ff1"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.215/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "b4c40b030f85b4d575d81ee5ce36fd995ee9e744bab5bbdc4bac69a991dcf12c"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.215/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "c1aed02fd6040bee34cf65254be0454caec6a491e1323de284681869be6bbbfa"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.215/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "9758c3377fa0b23336728fd0232e6a920a93f4dcb6e24a2098699fd4dffc2355"
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
