# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.22"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.22/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "9689f22a7d166f99954acd232054ecc203d45c1e26f788e6fa19005cc19dcd90"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.22/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "0a2441f7fc465960123757a7654764acd77fa4f99e9afea45566266abcf47d17"
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
