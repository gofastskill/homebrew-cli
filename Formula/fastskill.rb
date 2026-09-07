# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.218/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "485009ba9840e9670e2ac0ef34859edb33c73648e85044efff19bb979fc2e095"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.218/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "8ea3b168178bd428c934d06cb684b1d86144c5ec696fbce06c1af8d559ff72c6"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.218/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "cd96ab5c5aa2373742af1dd8b448ccaaa886949704b362d124fd4625c09f9b53"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.218/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "5fe022ae3c3aa56deed21ff5f616e221c646dad33e22debe5dfc2d9744fa7b01"
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
