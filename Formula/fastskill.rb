# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.222/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "d3d3bdf1ccc1d89e642e74ffad41c78df72a0be12a56df1bb8abebf80a242111"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.222/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "a848e9616f7175947f3dd3c372074afd1b317bfd10caded14336e175f70227f3"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.222/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "18890c7debfe2df197bb4da25cf57d0c48f5366dcd29694aa80b440d1882a7ba"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.222/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "96c31562ed88da2819c3fdb0f9e6bf02b2282e09e3b1418f15939264dd4228e7"
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
