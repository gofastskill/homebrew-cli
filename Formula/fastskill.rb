# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.225/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "302b7d72a616f4d6cf40a80e23493b174828ed41563e77e8e842d9bc0525e135"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.225/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "84b76124d8f028209a6347cd45443ce2c7d7a5b628fce8a6c639bb3141b578ce"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.225/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "9e239b3437666fe582e6766b1197e2cace0c83b49ea267f518e1929b98d81f2d"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.225/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "963a690f9d8d2ff6b185709065dec6961d63289036238f9486c67777a5263e52"
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
