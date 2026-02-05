# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.41"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.41/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "0289652ea6cc2d5acc6d659f751283c289b2352f85f4cc4a4fb4f339f412551b"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.41/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "ee1ba1da48a1d1d1199b2cd861806db96afe8df8732d05b291f981048feff88d"
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
