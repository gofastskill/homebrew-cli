# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.77"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.77/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "ef49307ba55df48315528d93523cf762480fd28218e592d1ab9795d209bf2096"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.77/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "41cf954bae05194ca5d860224f49e63f6631415d3d03d491ea74edc3f7f812bf"
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
