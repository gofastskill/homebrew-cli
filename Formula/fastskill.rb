# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.7.14"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.7.14/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "cb61d550085163ea2a3a7a5848d96e08a60f28a2774ff8680827d18e23a813d0"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.7.14/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "e5eafed2fefcee87af271686197b0c62be6f63965f60d05c66da93bdb08798a1"
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
