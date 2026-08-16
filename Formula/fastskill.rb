# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.167/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "e435f64c18cdae74bb7b03be40070192f1963d50ab2d9f0a65b391f5a43f8464"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.167/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "208c509a048db0f9cc4720dea0e81bcc7ec0d2128cf4e3870205eef8af4b0a66"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.167/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "6b0734ba2bd53cf2db4d1102c47ea617901fd5096231d13b50631069934e2ca4"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.167/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "da40db5d3d8974dfd137f82a826cef2c45e5e9b2cc4b6d96e93f09df0ba4f0ed"
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
