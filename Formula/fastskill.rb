# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.42"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.42/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "29d8b8a6283b1ecd02a0907897c849f7d14f60ce2aab99f382951038c0459d0e"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.42/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "1ccb6781bad699921f9aef2d540bb693d93215adf799085a8d3233b1df5809af"
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
