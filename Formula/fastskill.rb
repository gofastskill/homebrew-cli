# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.49"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.49/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "dfb583f09a5234f60575f2f7f42a21d5027c1e83af4bb25e95f9becfde13b5f5"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.49/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "b7ca8bb9fc884dc7d84c663d00b89231fd4aea06c1a44e4ad279de2ccde54cd9"
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
