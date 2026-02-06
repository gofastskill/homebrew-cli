# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.45"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.45/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "cf194bfada5d2c7522fb20a6427e2fb815c056d6536bb9b538e8d72bd6e3ca82"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.45/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "379ea1c835e9abfe7bb7c4d3ecb8149067095cf06b4a5151c06ba57056db8357"
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
