# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.86/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "cd85c73d12aaee2eefc22dd80c5cb45b3e8c5190a2a00d6314d79266a1243cbc"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.86/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "b2aa23679a9f408b6c7a7cddec8440158339061e487c6afb612023fc6d2782e3"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.86/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "60e7272383514fc5c0151cea9388b9726323b6e5e4f952255fcaeca1d371c4be"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.86/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "e61c0e8a3b371b3f7324e189f09d2831638234e005494b9c5fdc97e20b7b0d33"
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
