# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.242/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "c8cea38c6a6ec732df291e9458da9eeb7198da8fbeb0d8c3e534344300095c74"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.242/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "89f2bbb84613ba25c7be588d2de4ce24fe3b415e7c278707511ccce98f1fe7ca"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.242/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "18d8f9535f981be04916bf0dd3e7ee036ac736cb26af01c7bd083209206a7aeb"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.242/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "1e2dbb815d24419438696063c0017dd6c639ef4ab7b0789210f477a97c2fa11d"
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
