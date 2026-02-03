# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.20"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.20/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "05adea575043dd23f81b034b87450ce963a1f9dde31a7b0eb9e51ccc5926544d"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.20/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "f7f147d33678911ae1b27964d30324ad7680803fca988470b8424434a5961922"
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
