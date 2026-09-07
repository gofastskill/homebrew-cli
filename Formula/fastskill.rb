# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.217/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "166eadbf62672bd3a4b2abcbf4295cc56d388dc582eb8606ae4c2961b10fe01a"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.217/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "351f02c079304566acbe0a7e7398fbd2727a7f8986305b9450c6ef4630c12326"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.217/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "519abdd0d285c42f2dfc877effda655edd10a3ee5bc333a20c9530fa3880ca5c"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.217/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "6200d02cd49a966b00bef6f17d43d263bee26efba1e75a69a6ab4256f1ab42b1"
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
