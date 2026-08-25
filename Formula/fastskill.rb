# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.199/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "0506e5312afb127a7d435723f40b7163b7508ddbdaaf89f4748fce0593f0d922"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.199/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "bb0fd2cf3a83bdad1bab0438a55af63728eb4baf4484b7868471d824c950fc90"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.199/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "f09435718f7141038cd35f1431c539364c71d4859c7debb211e611d305464f8c"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.199/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "c929ba5a0f2dc15efe9f2587e9d5bee69a7838a5687d8b026708efe1ce118f5c"
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
