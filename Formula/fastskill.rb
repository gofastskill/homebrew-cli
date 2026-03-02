# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.89/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "7febea0fe8a21a40ca05157276faf1b8abe3314f744c987089c986ea598da1bf"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.89/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "a94c6a0014ddc07ef32b8ecc557d6560fb12846df0b30abe2983aae5dde38622"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.89/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "4fb103971a7ce50933106b3928a53227b2a4238a1ef7fddecf1b4f1cc5f86786"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.89/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "fb70d36408120e943ab5d7b55ddad26fec386aea4690296c5d90f8897521ac82"
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
