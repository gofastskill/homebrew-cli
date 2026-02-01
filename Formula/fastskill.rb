# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.16"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.16/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "16f3e6e48cb5e8995eb68c461e8e81aef85a14df99902b8d6013f3ab89cd6c4a"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.16/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "4457031344ce437edeac3b655f54dcc185a8dcba2c3ce464c7adf4aab4cf98a9"
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
