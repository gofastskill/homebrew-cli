# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.273/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "0fc571f831146249953ddfeabffbd5239977adf13f4dad977400831a0fcbfe29"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.273/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "f06fbcc9b6dc46da084dd4aee8c5bb7825a79c47b252f44a83d28d84767fd55e"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.273/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "6bedf4a1549c333bf3e55d9a599b7955e114ac7bb60e6dc5b50c5e28e9e074e6"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.273/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "0f3141078bd61afd8cb32a65fea0cc6600b98e9fe81362e8bc56bcff3151ec9f"
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
