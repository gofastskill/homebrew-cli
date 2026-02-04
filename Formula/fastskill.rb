# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.30"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.30/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "d6b717e2d9c816a11b8324a6ea0fc642a587b15418660c997c7eb5ba0a611279"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.30/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "403b04d598c67f185f73854112969ada76f32e0c57b597da0e6bc8f57c7d9708"
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
