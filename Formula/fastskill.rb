# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.18"
  license "Apache-2.0"

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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.18/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "24fbeb30547f89ae4e0ac493aaadf972b528efc7af78b622498d09c147cc9329"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.18/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "f1baf1fb72a6543c7588534b34acd9c6d36b1deada792b76586fed49aa7a250a"
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
