# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.44"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.44/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "97239cebcce838a90683cbe6d260a8bd67be87850028497cad056daf8a6b5686"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.44/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "1d16da5ab05957a5fc23232fe85fa81b0dd0e991511a7ecd320199e7c221a6f1"
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
