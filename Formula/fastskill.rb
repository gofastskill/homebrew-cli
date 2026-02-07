# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.56"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.56/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "a3c2526638829e026e3e758dc0c38a9fff46b6bf7a3e6427048637879efc106f"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.56/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "9bfc7fb7ee51d86360f9f3fecd5d1c750e609de3483cdf68a6d7a38198b9f0dc"
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
