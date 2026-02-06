# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.48"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.48/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "b78d95e586065bd9c429c7e52e15f31a44d4b547afe582dc52a648ea96c48c36"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.48/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "9019d92369314880954365aae94faea832d39ada3ad6045ea3aeb02a6669f03b"
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
