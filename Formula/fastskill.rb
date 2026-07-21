# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.147/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "adddfa404d49a3a29c132a430d8acf0fe204ed8057e78cdf37f1f6ecbc79805a"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.147/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "c6d975831c4a8bd3d0ec1c245017bf7ea74484224a41352a1588900da421a509"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.147/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "df3b0059ab7f9382a630082af29a3fe944de4dc872f65763ab04cdd70800692c"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.147/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "522e04924954b908fb6ea327b84c433defe6e60cdfabdfc4fbc1d419100337a8"
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
