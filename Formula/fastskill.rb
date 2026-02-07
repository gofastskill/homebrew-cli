# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.54"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.54/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "a245a89a7061d65274664c4220ebfb6e09c4a16c41ff0fdf9e1744cceefd21f4"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.54/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "955931c9c96980e56893ea2c9395390ad6d21699d7a312fafbe0dec29c73b7e4"
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
