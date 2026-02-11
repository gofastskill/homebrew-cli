# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.60"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.60/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "a62f4fcd2a44f39cb126d232ce17fa8affaee41c7c7c89125de5c43eb6815769"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.60/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "b6e92ace30d4350f32581bd46f28df5000b53d7d542a99038aba26f816d554e2"
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
