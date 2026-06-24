# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.139/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "46aff60b2717abcb8a026a47f96ef1d976f540c1b04fa8d7330219e252507198"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.139/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "1774a9371e599b7435fc4a9fd854f9051051f6a58e22b499b3ff08d7772a6eba"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.139/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "9ff44af409cd23ec131b7208085e427ffc42d5227a1a6fdb359c0a3b554f62b9"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.139/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "baba1a2609df26c21c0c9c606bcb2ab41be858e48ab03d3e326a07fe3a475084"
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
