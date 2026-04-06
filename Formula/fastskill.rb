# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.102/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "1614c8dcba997d091e0e87c066e0871b272ff1865f70cb598f9a71fe62280731"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.102/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "df0ee6338cb84ffe66956e57fc37688483959ac64f6f00985a2822732d49d410"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.102/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "a9462692e3262febb788dfe5dd7450047909873d3f856cd07ffc6ff6bd337de6"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.102/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "7938048ec831d55b5b4c92d4627ff9061a11ddacc8a838acfe45259726ffbe7d"
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
