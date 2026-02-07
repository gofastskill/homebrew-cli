# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.58"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.58/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "4a4f430aaab3fdf315057e4942ac8f604526da9f4311d2fbfb1baed9b49bffbd"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.58/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "9da5236dd567b2b6bb92fb33a3d4e68397fa3d186082f21778fed1ef0babea1a"
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
