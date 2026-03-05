# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.92/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "2e217e8021ba9152ae0e5f28cb505d2837161121148c8928d8db1337edd4d617"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.92/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "607cd81910b66d9b7189ebff4cef4efecc0540daf76d34d3b1591ecbbd9610f8"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.92/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "b5f6b8dc1af544082a16c38039cca8a51dc0e7f26289104fb7c0ccf0e032bce0"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.92/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "f901010872e53f51321da05ef7f9d9278e533ac6fda1a99de61f7a18746502c4"
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
