# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.239/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "a5638f7385f0088785a9529156e5b1a4a97471f32af5bd348d7d912b0c728087"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.239/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "269cccd943218e22ddf9ad20e5550f55c8427c2ce489088b488956155395a2d4"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.239/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "dbdb58b52b8abf116987e98c0fff6d079167041f3306f4b301034c1d6f6a70f0"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.239/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "6b828965c947c4ee2352e20c21f2b6a4306f8320d354de6c28b5126ab2182400"
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
