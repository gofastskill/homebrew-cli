# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.33"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.33/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "ba3d126e4bd63afd90dd3623dfdf4476c91029ad962ccaf0f7b5ebd3597d5622"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.33/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "46189074eae15947e03aba6c5e3065e815f47d172d2bc9c4a84508a69ee23c75"
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
