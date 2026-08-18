# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.178/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "b2c2047aea4df7ca1990aa92a39ba772e068763359d7a4341140797c7e1eeabe"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.178/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "6d697fd89fb12a5d76d7ec19739d43530cba1cdaf63bc1670afacd766fa68db4"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.178/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "af2e9de75269350faac375277bf4de05c8673d3776cb15bbd432009377aad5d4"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.178/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "19d04598b6607d1a591e5e16990f7290cec0d142cf65b2539f2ecd9633b2f5d2"
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
