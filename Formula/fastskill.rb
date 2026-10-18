# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.276/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "27321f62b0c35cfa0fbf3dd07ff7b5ec6fb36649e87d532a06472a0751debe89"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.276/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "0fb60bbf9d27ff99b31ff7167d8aaafd066bc855aad88a86843b7bc1e3c41187"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.276/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "c52bbc618541367f475516a39b4926be9428c5fec75b6acbb83b05af00a6a62e"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.276/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "ff4df0b30785b8c408842dfcf0ceb6d93e356f1e444581a0a8f0fad0c4a4a5fa"
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
