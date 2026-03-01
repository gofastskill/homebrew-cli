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
      sha256 "e46e539f12b4d561881f843cd429e23a1c8a5fe8ff9b23edc952f153ff450c10"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.82/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "ef388963bcb4234034d06b5ad49c62dc46b88a6c9e347421fc503ec9f7dc3eaf"
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
        sha256 "a9132a7e4cff35180d6bcce8d7b66fb9b02d04fae2c2026ab6aa4243977ad72d"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.82/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "bd153d21d72cca9c0ee6a0e1fab07e8b226d7d2345666b62a459f76fe689120c"
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
