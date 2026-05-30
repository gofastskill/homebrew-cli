# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.125/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "d7abeed3014cbbc8aa431455351f241c1b1dde1e413cf32d7bf2f13e48e3561e"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.125/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "4c8a5ba71ccda482bf9b7b10fc12de43b602eecbd377368c59d6ec528e6caecd"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.125/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "7497e356ea69a24add60729f1e2eb3ad5f245062920700bb6954ee2485b663bc"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.125/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "cb80a356bea8369d56487b375102067969fe8d9e1157dc250953495039ff2c22"
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
