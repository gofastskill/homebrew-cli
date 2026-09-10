# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.226/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "5b59155f186884310380ef0251c1a6a9243be835ecdf63dcd7ef701c105dc072"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.226/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "9b90c915bfefb10865fada329846e5ae80ef5491906dc06e3853e8c71d3efa3d"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.226/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "b17d985f23fe13ceedcdeb683ea3dd7da78d015bcdda78838c4b7d38a1bcfd2b"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.226/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "393051b4700e23bfeec62a4966910fc9889cac09f122a5d5a38d7147d784ca2a"
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
