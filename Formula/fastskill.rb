# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.256/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "aa9d789af7cfd8338faccf6f0fd62eb6ebdb4cd0b32e6ec94e547ec0f2f61e04"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.256/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "cc4178d8b5a34bba752b2ab362f44320636675dc0f0ef80608446ea6000c58c8"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.256/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "4b73444b019c0a9be4dd28cc15ae4fa7a5e18de84e41a2300b81296338d8d59d"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.256/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "26cf9f85934da6862543a5aa31f5fe212bce426932d0e60d94f791f53396d029"
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
