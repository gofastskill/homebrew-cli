# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.23"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.23/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "960e0f980908f345efafe2ff2d5445ab6376f78d284bdccdb2ff8e37bbea8993"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.23/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "27d9b1c87085dcfe59b70d9f90591ac1833df7b59d28246f83cd6feb9deccdcd"
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
