# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.51"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.51/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "8763893a76894ca9d285b7d9dce091c22d6e2c6a75dcb167572a751bd103761c"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.51/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "77a9744c1dcef93c750c0aba65af39edf2ce0b731edc2448752d68af90cd90ef"
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
