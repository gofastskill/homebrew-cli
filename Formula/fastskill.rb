# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.198/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "d8708e1bed151b79de71ba2599ff7d22cc709622139c1d1719d5621843377197"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.198/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "4eadb842be51fa48630a5d6147d5e425faf0c49e72c834d55d0e0b24bbf26466"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.198/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "28cc377a6e952e3c1d7a3949a30fde05c62c40ecf206880713f65eec8ce7dc0f"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.198/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "c13af36276bb6ee7c59a2908645777e27d3f393c00179c770a775de6fe24cc4c"
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
