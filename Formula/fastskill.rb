# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.161/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "6df935f0cc1eba09e0178c4f89fc2b01b47f21c214e68bb1756b14f98ce4b38b"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.161/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "a6c57e5a41ffc66b005bb25a0dbdf914917dc3c014703c3568e023f65b472448"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.161/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "a76fcd53245de5d12fb30dd82757870b0553575d9e0ec49d7c85bffc83ef42b0"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.161/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "5743103a1c16de52a4335f1ab7bd5e912755be1fd6f51a24b3f2acec78f64d40"
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
