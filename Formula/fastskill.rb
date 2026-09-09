# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.224/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "0437ffd42beda1463254db7bf19631963a86c60134ef9209ed2ab79690c0666e"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.224/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "bb3ed3101621484e7b6bfb9365ebd1d5df33a798f4d3333f4b879e0d36d49cd6"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.224/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "5c584b52026de75bf1103b98eef8427b4ae057898e300807604e2a5b3c0b876d"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.224/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "7baea6c1b2b22db066910a8794fbbc9384f8617936a15de03e0f1447f9bfb367"
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
