# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.132/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "6f39f95004403fe9e797f6fdfdf9b56ebd93a7a858e79df5127a09504c711312"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.132/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "637c61e35d31d5d0107373322e041010d15a7d954666ddcc7ecaa1480628c200"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.132/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "436392e6cf459970159a14839da8875cb1f27bb1579f1cf124c4346188247950"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.132/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "88cc2a684192b199d5efa8c30e7cc76cbbf2c67ff85300574814810f5aacb68c"
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
