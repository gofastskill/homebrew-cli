# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.236/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "1e8f78fedf4516beec3c23dce9255720f5b97207c715d4d0c0737b9585f099d9"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.236/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "e93919eff6668fde1914829c287b82eb29ac8ae626c5d11f8be838e4fc906f3b"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.236/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "fda7e7e4859769351def8c00c5912ade718713f918f13caec5ccabc8194cedea"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.236/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "346faddf977b93cde299ceee9086caeecccc55eef719c5cf97f910575720727e"
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
