# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.73"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.73/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "76ecabe05dcc9ea8f1d06195197e2446b44d5b835ad96dd5f71247265a0fbcfc"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.73/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "dbf4c5d44458d5b19b0a7ad3eaf4b08abf55141f4173bfe7e4b1e152e38d093e"
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
