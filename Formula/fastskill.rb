# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.246/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "45280b453eb3e3e4e024925a3981fcb8d033dea9b4feb133e030971d7867dc59"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.246/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "aa0e803c43c4c706ad80cca4a7e1eeafa555c618d707431b3df552319a6ded5d"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.246/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "0c05cbe25d641a630039c1e44e6dae8b14858e83f950b4bd3cccf847ecbc16da"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.246/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "6be035776694d863c7ba589aabddd725b896e00eb36119528f2c86d09f8de899"
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
