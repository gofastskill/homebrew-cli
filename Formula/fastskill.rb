# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.243/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "e75603896bf8b6fd6fb7baa1295a0dd6339b3db865bcd1b5ec0d19eb2dca3a31"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.243/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "48a707090d269a734c3f779b5a2388a6d9dfb126b673a90659131c356ce28750"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.243/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "f689b2b1342de85ffa7e946993c629b5e2b3db39cad4a899b8a1ee8c4df300c9"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.243/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "d7e67d22362c112ad25b8f86331bed046c5553a6614ccfc77561183466c2288d"
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
