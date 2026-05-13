# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.115/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "4dab7bd35a773e1e76993da69668713574d8a1b630d5795468c058f541aa69d7"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.115/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "5f8ebef8b971fbccc427c9525c1ee06e231f1d553235f0200988a47e035d8475"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.115/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "374c2520f08bda79cd12ad9ce4340b625968b5af73a66f1f9df51ffb3b75ce5d"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.115/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "5b1b72d19e070729cd4ae7dccbbd4e7afdfef7016b5f875e74475fe583274649"
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
