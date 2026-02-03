# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.19"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.19/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "3e625d86c1e1c04066e40d3ac21ba3e56ddb8577764c541950b33553d5a4a2bc"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.19/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "62e2944837d4219832d7b7e5276dfa884bdb9f097f7da84658a62539d10a1b05"
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
