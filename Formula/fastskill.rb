# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.148/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "d15d6605f9505847ee53fe8f43866fd7f347cc7714f0dc85c92861264de348f7"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.148/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "10c74dd7371bc7fe7770f39f9684e565872f9ffbfa16d7505f3f5dd8d55e0b00"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.148/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "af71aaf7ea85d476dcc416d9779a3068330c98be4b4263859afd44a1028337f8"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.148/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "bd398e6dc0f847da205c4851ead5d0c742fdbd7e5b99ec995a3e7db53f7b08f5"
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
