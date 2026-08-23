# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.188/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "30ab0d6b3043358cbbc6c19a44cf57f92dcae46ef2aa2b7721890689952a6b05"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.188/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "bdbc0293340dcf66735bbdf7abfc2807b476c88545be69d2de2ef898b0bed79c"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.188/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "0d2cb5a497388e60ead23a804622800ea80dd95b98463a8d943eca910ca3743a"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.188/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "6c5c0cfccf797f552ee7161719dd1bc2c27b60882a2d353ee559488175d77f12"
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
