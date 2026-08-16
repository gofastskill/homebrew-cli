# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.170/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "9b426a987090b4f091267657b850ca09485df7c3d9d1d019d42cd359504b0030"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.170/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "6f8f93b09e6bf675ed7955dc2a54e524ca15a6216513fa2cf6c99614e311d053"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.170/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "60f6e173285abfefe4b9b8a4f841c6caede08c2f569c6ddc736b9808e42e5865"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.170/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "7e6091fccfaacc15dd8dfd25f7c45094baa9b1189f98b4b805afbeaf5768ea4e"
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
