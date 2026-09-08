# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.220/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "0b49f3837adc8ed9327f84e7efdaf36661ab50e463f2e60425bb48212cd9cf29"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.220/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "de3e3d1cd3bf8ac22d78ecd5fc58f2de86c7095cd66969d31025278fee23d98b"
    end
  end

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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.220/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "fe4d04c5d343f72e987469150ae818a90f182811a6c2ec4611ba7d5b0719b02d"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.220/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "6822be0f3bf2579233888b7371b5f9e637980ca101ac3591e10d800e26eeb56c"
      end
    end
  end

  def install
    bin.install "fastskill"
  end

  test do
    system bin/"fastskill", "--version"
  end
end
