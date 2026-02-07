# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.52"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.52/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "4fd7b53d288e1d0f3fd7f3ed50848e6251d25aba1406106a7814ccba54c4d300"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.52/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "1e55de3214383ea430681a22a398a66e54c321fe1471974c6f54672785bfc55c"
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
