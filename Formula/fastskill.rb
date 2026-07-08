# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.146/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "5060e50ba3de43adc92df3fa35bdcfb815f2ab4dd4b6819535514a79f4b27faf"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.146/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "33fd106c480cf6a778dd91f9bf645a83bd621908dd61732471f0e8fa176490f7"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.146/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "fc251891608ecca1d37ac80088f0a332d1edf5314ab8f675ee7b460d87d99f17"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.146/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "aaf73fc4c2691be1502fe51f648858d1d6b03d671712445731728a5f62902f9b"
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
