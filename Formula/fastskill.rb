# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.212/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "92c2b17f13dd38dc3387bb1b3b75ddc2de2e60486ff9c83f1ccea701ebfd50c8"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.212/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "27e775bf71f00997d647e8324493510bc255120900cb267a3d5ce74f2bb07ef2"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.212/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "73849e137ad163ae070ef74f891d0971d1ab88be8c613a817886b77e6f6f5c82"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.212/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "463f963d8d1038b2ae28f9dc1c6b56d51acf022edbf4884da0443b0c757050f1"
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
