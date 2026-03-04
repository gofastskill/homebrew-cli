# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.91/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "1aee60efe6cd7adc4fed3d46e3acf0993a0284bb8b89f1754ee0183b4783d951"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.91/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "2d6f7ae6ed00d24bae3a3cc1bc765166e7a9a5999cda6d97d44dba06352d802f"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.91/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "142f6f249667e1bffee0ab503e5158586ef61cec13990f522307e23fb60504ec"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.91/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "03b5c7bad8732f1e5a4a921b8a10cd19cbf365b0305795b25f0ca9e9a7216574"
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
