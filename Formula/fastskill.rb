# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.231/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "be5d6ba6732869e6d54be096dadea84306a9ce5c2a7e8c00138013598f82a607"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.231/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "49393140f0b0d75606ada597b22108700493c200494b9e181b0be67406c65ebb"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.231/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "f1308f929672cff88be09f20e72af9453e47334f5827bf0220e740a597ab0b18"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.231/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "3fb757e14c85ef58882648b7b5be643a6e4e0d5008ce22ca282118042daba0a6"
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
