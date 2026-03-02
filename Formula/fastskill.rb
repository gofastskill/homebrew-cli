# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.89/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "e724b51d243d48bac69e6096a8798e89384987f2c45f98cfe1b28e01fc1fe0a2"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.89/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "76b042ecf5c630b35cd70454ebdfb373bbc6b09af6357db1d4700b097376f91c"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.89/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "6e34bf81b85e6b82340f9d6bf5b438de695ebad56c7e0c577d580c58b8c771b8"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.89/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "037b2190c5e4726f2af5b4a1e925cd490c84787862b143948f8cb3be954cd89d"
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
