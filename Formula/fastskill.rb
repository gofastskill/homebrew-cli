# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.21"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.21/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "175521874d6a06f5ee308f9bcd6733330a96ea1c53773ed4ebea20dcfc439fae"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.21/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "5954e5e9e3fb11f2fdbbf6ab39eeb2f847a4597bb7554ade5c5efcae06fccb06"
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
