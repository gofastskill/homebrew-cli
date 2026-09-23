# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.251/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "e7b697d491cc00ba99f3edc8222ff2ffaa450a8d00d59cec632669e18a228257"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.251/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "d20025bbf935f01df533b8ac96ca2dd5a0e61260f85afa6f3722cd5276448f32"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.251/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "bf22ac8dc260349a65d1b1882a59833cc4877ecd5342c669e4347a016ea8e4f6"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.251/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "ad084be9930baa8fc7dc618adebc1f30178731f1bce557c5cd8d2987eebcefed"
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
