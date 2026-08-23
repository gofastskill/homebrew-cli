# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.187/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "94fab839bed6dfe08c99eea2adac2922ed405226b5bdf387a83d4a425fc5d793"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.187/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "d7c00c97b5ac6c769ad300e3acaa86bacafe31544fa77c1aed058fc1cf6ddbc6"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.187/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "ea7d9f479c7eeea3b43754d71f7ab4b8e837941d8660b2789ee8a3956fef1aee"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.187/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "ffa79cbde18ffb9bc7ef5255172b60394162559cf4a5fa9edd33fd40dbcab414"
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
