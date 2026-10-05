# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.260/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "5edb0bf2f498ef82cf3a4d7c31675bd7d5ff02e6c880ea8d872e8e7d5957308b"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.260/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "5685ba3ef9bd51ce981ffad2460b5a861ac8ccf97e968940d1c161887bb6923e"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.260/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "4146faa9e6a8601bda22230e1e0d0b81792a875a1fd846726538af569a2ed54c"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.260/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "ef8f234ce16b70738ac16c32ff4d5d2462d168e1eeb7d5b9c6ff928184333f1c"
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
