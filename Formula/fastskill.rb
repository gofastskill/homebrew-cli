# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.228/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "af7ac3423111400374ee7f0689840f1f9eb36ad7929aed8a58412554f64241a8"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.228/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "6471521af7273a971e324a88a9fb22a73ac6798a26e3bd67d616d5fead74fece"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.228/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "9ed613dbce45e7b71ebec31caf701869c231d3de7ac70320bf26023daeb27069"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.228/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "89c92a3b4938c55fe38f64764cada27f2baefeaedc2f6af2410c15e3036d7aa8"
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
