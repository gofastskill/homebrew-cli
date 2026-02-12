# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.68"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.68/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "747185ef9b1a5c5623fc9fb45e1d819d40a32fe104ebc05d68cbc0de3e31b4a4"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.68/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "bac985984dd654180358dcafc4da4bf4f75aa2093402654f23e2ff1a68452834"
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
