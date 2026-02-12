# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.67"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.67/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "6c88832db15f5b42f389dae1d7ce5d1251dfd185c67a576edd2f5be9a1321f71"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.67/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "90b04676d45c5d3e26e85fda896fa37935e322bc4fef703f1da4fe0d8dca4507"
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
