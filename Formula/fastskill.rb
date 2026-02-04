# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.29"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.29/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "296f0ac1e82b0732ca6ffa18384847d8540005cef0abb37d28aadc266bd6939c"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.29/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "323a70840464c491b7f84f5f82733ca329c7e4356bf3746e0d878184b2d1e0ca"
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
