# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.180/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "82bcc10509c986aa574d8a13f5f9ad87ff0508700cf434c71c2d36b3964d61f6"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.180/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "b40ab2ae077565c23dd64c5df4ecfcb7201490eeadd9683485a26bcc26717ede"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.180/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "70406430b8c723d229badda85f9c452718d35212595fc173714b502bdbec7ba9"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.180/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "c87c67812fff7814d868654dab404fb6e712384fa9bc5458baa2061a7b1a270c"
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
