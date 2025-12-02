# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.8.6"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.8.6/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "c527501d2f08e48cfe9a5cbc22d452d3e4e63dce9cd8e4ebec97796a8d0161ec"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.8.6/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "7b8e5f09a82228452c67492ebfb1615b4ba04230028c11e62f4c7ca2bd8b9d7c"
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
