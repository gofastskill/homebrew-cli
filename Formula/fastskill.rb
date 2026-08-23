# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.185/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "7c049ed2cf57853b88d6e9038a4cfc2374fd8d80f70b6c95d87c06ede31f28e9"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.185/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "9783106e40bb831da5df6c4fe41464ef6d898a2daeca6725b94f64d0a1ee340a"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.185/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "1acbd3eb972740fdaa2818b7422c782aea5d253cee2e56d653bf275b09c94759"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.185/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "7e588a7014760fc8072c9113d6ef050fcbfd10591f4729cb034140e8190dfb8f"
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
