# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.213/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "a1f951c0dc49b130404d6b86c21bd5eb1bccea014d99ce23495f884a253b02e0"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.213/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "c5c4c164864b588d6375e23fc28cde7f8888ddc7bbae75a915977604a76e8274"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.213/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "bbfb0d122bbea0b06f68351fbc39dc0376ecbf887cb8da465ef4e13149cb8ca1"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.213/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "7cb8e6cbc79654176eee3c72745ace202b844c048a80ead4653bc8dc5857d5e7"
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
