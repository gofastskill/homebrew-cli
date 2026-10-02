# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.259/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "fbf6506ed2abceab59c9afe0ba12cda11177e6f988994b5e084c196f456b6e75"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.259/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "34216d9a570f838898b415c4cbdcbb2270f619639b4461f1be01e71b1b177335"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.259/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "46fab59de65cf5df30a7d7ba460b92b748e0b13bdbd1d0a42b1f8abe6da95ec3"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.259/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "9e4fcc0c9d785162b89a1e222cd0ffc8451fc1c5779144f0addeb10d76ec2e6d"
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
