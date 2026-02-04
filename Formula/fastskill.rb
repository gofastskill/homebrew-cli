# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.38"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.38/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "d1bb34274beac42d5eeba333cddd3e70c1ca9a2c1a6160611ada034b7304ab5e"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.38/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "3d4428fa524b4d9a98588703ba9d9028a989ed917b357ca0ae3662522fa2fbae"
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
