# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.118/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "d79d96e9cf52d7404c1f493e9614e3a2539f7147ac191b2030bb02f8b840f635"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.118/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "183a9dd4f73b39ece25aa46a15c75dd21ebd61fa46ac9674f7e0f73bed980c7c"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.118/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "df0d50a57db9b79567b7121934546eaf75065f03814132ed021692436407666c"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.118/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "c808bf9ad09877579b0929f03f26bacbedf7195221a0fdfa0c7a18778da3a92e"
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
