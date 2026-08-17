# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.173/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "8fa4a7fd352678fa85d37e420ededdac50d89957711a2b2552ded4d5c3654a44"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.173/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "99f5d27c3a8206eb25285abe0565b63d1e84641499bb4be66a7e3779e3829c29"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.173/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "69199dc17d47592dabe23d36982cb644f4ee69e97336352751902b8884a06bca"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.173/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "465d163a541465b9164eaa3ada37bce76aced79f27b18010a314670153ec134e"
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
