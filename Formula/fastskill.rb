# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.85/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "ed5b52492e9e2c3070d8a7c701e51ce84332247da3c7e19282c7e50450ac4bc2"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.85/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "b3d33773ecfaa34b444a26130df251e2f995e1812273d3195f5da496e6de8cdb"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.85/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "06b19728174c6b107dfe419d1ff77a12d7828e1e44d455ccf7b5c8e363139f2c"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.85/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "28613263508a2254159d4a7a2d19956dc25fe5e9cbfe279cfffe4128b179f945"
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
