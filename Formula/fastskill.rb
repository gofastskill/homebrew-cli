# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.108/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "63c4e9e9993327d0ba35ddcfb72092d7ae02600e2bc4bf1b7396389d9a82c1ab"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.108/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "78cbecef07ac0f6deed9efcd9a0314399bea26fff7c698751d57101ba6122287"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.108/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "46f0bcf99e2783a417848b0804e6d06b3aefda64bded6aaa9ade015a17630778"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.108/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "6a2f2701fca1a793be944bd4706b3374ceb0c4adfffc31a5175e7112d0c939f6"
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
