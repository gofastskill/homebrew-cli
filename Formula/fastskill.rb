# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.171/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "2e8494c95483b7bdf401bdbe015aa65ef25c94a837c66f76140cb0d9f162ecd1"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.171/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "5126ca0c3592a923c363838f943277839b52483aaf46caff7d71d5a27d8e7e13"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.171/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "2328ffa37a87e8ba83458dff431bf2fe7099c33c11ba726b81ee0d545ff03b7c"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.171/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "6c9a236101aee1e7938e3df9d5bda54019124d7924774002105b39496a9e1950"
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
