# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.200/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "9539991a23b2c2d1e2dfcae71c886f48adf62d47a668631226db95bbb4688ad8"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.200/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "7ae198f57abc593781254c55a04ecc5bee30f2bc43589239b8b1aebb12ec977b"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.200/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "7ab22826f23accd17093f9d7e16eed9e2cf5ba13d0f97d56331670e12ff3a7ab"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.200/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "490333c40050c9c0179aaed1603a3090fe445770e02d9146f2235a6577138cc5"
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
