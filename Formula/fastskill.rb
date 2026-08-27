# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.206/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "66101e33d3b8bf742d57556cf84509d476b26ab936d3542216ff07e0eb38deba"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.206/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "a0538dcd371b786728bfcd4ec55c4e7c295a252a39d646681c959fb1b9afbe12"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.206/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "5200efbef918269126b7af004b6ae9706c09cb5652c9dd154d3782e2fd75d287"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.206/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "bdd17257e72d0b69813ea4289e3f898e940067e10edb02106256299f12f8223f"
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
