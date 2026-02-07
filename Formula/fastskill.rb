# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.50"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.50/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "7f3460a802e7ce4565f5522251243d393994abfe69f3f22d523b9bafdf1b5d0d"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.50/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "fbd1bbbe34e9a0ed342e28fea4f99ddc97f58df9378f8c12b8c6adad823f778c"
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
