# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.182/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "52a5627d7e613cc6d477ac9034988ccdf7617a1bcaa9630f54a23a99a1f7b79d"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.182/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "80db7a7152e7fcb893c63345f04e73c4a72a70ec2facec02817d3b08ca03d1d9"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.182/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "dbe13af2d8c1448449e51eb7e89c577c86ce3413f3761275992d5283e8ee9757"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.182/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "0f3017d7d228786b346d619c05d89ae145a391dad8123c48640b242f4b2b0226"
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
