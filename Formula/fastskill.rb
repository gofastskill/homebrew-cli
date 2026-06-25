# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.141/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "94e112574c34841f81c672f5e276de81349ad25d7dcb0d2b204f144d47332fd4"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.141/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "2f6790abc568e6c66972eca3eeebedb578007072150ac50f619a511743ec73f8"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.141/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "d77e30c91f4b64bb27a7a4d5e25e3fc45df168daab9248af89217398e81bf683"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.141/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "5c154dde4bddd1fd8f382ebd236552b6c8a77c209adff3203f2714c4c0096f39"
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
