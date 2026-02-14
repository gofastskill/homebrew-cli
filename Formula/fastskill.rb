# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.70"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.70/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "0368cb7c8ddc6cc5fc16131e6be84da59032517b4219865b5ef2077ebd16b798"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.70/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "4af53575711f79735cfc90859459f5358643a662f5b67488a9cd0cfcb2e0dbdf"
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
