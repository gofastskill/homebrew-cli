# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.152/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "d90be3c0d8724946f8a37a39294f157186bff8d0ad502cd07e74e64b9f65be51"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.152/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "c743526120c0b286fd0cf4f713f82471f7bfb102fce446e80d1de729f09e68f8"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.152/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "ceb943759caea4bd17ae60f3125a12cb980f8d9127f457213db895c1821e1a2b"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.152/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "98279785cf7c83580936a591c5fb16943603e03b762a97feb6405456d849c36f"
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
