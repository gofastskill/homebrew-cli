# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.31"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.31/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "78b6127f6bd66eaebaed9cc32e7f0e8bcaf01b596611589227b77a59833b1fef"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.31/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "b93f80576a08ae43ef56a0bcb429de48c58182ce4322bc33bdf995d720dbe34b"
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
