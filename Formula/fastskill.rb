# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.258/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "3c5417ab2d42c568026586bdbcfc959cef1c57c4da0fec7896624afabdce40e7"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.258/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "ad67822b918f36b20487c5cbbe9e7e0f3ab6cc7b2ea4faf8eb78acf72bd590c3"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.258/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "8f46da82a405219a252c529bbdb6c6af257ddc6fff001be1dded93ded6065a35"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.258/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "e2c84b79f474a9867042a8bf981eb59d58b7eb50151e9e973b3aa20df9aa7811"
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
