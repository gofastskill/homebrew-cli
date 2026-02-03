# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.24"
  license "Apache-2.0"

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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.24/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "6f761a1025ebd0be626b48363364765e9c9c19c705fcf5cbc8b2b4f38b05e984"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.24/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "59e7c2b3eefef91b7ea65232c5e9a7f778b202fb4bd2db2e39fc3edf96bfc51c"
      end
    end
  end

  def install
    bin.install "fastskill"
  end

  test do
    system "#{bin}/fastskill", "--version"
  end
end
