# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.34"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.34/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "49ac63afdcd8a4d44120b35428f8c1662dae46818638025dac9432b5f0c609de"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.34/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "1a471833086007dfc295eab247cb702e49e40840b7560ed22c0bf0ca7c1c0c88"
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
