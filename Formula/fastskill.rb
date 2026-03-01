# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.82"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.82/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "a2f22e7164ad0f7bfce31449f73655df7a2035a297d90db27e44bd6385d564c6"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.82/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "eb679b27e50a94a146b9289b6e7f74d3d48b3a473f4c7e274d6a9edf507f7f6c"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.82/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "7343b9f314f28fffa8ea5bc3b1142df7ff5c6f2c55df695a81cff1b8f8b50a77"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.82/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "5ef2379a75ed1a5a8c5844dcf74d9145a198185c1fe2bcd249785d4e1b8524eb"
      end
    end
  end

  def install
    bin.install "fastskill"
  end

  test do
    system "#{bin}/fastskill", "--version"
  end
end
