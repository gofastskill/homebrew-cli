# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.63"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.63/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "fe484b8c9ca2780f17023b210247e5a9c70c624df12015f4701bbcb18cb658c9"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.63/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "0281d4a0693e8be040cffd4eaaf8f35f581d81477f9479a9c9a71275b368084b"
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
