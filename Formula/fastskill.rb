# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.216/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "77623cdaec65ae42c401d670e6b0047ff52dd8d5c3fdfd3f4ff76e8df849d940"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.216/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "8b4b6baad55911a67b64d3da4ad67484426f0cd20def9126b0c2535949712512"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.216/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "c3df2db88ed111c15919017dfb1bb6fa32fecdccda366c24a9afe1a21840379a"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.216/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "9f8939e81a446cd144fb323cbcc964423e873c91291d2567170e08e92c21a9c7"
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
