# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.32"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.32/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "e723ae36c921445ad82d842dd377e786f6badf77b8bfbefd8e8ed65051271436"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.32/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "0aac23b001cfd85200df8b7446864002e25de61c2f7f8942cb8dc131fc2d5c62"
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
