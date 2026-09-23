# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.248/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "970599953033e79d8971f38a4eb9088a6347caa6456698b41664510f6f1c62fa"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.248/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "5ea1e40ac3d46f4f47a69edc867d213eaec8bc90ad1853e8ecb72eceac91c4e9"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.248/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "3f504fcdc1ad619f28dec72a48ab2695eb073edfdc5b1512d36c08c92824c748"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.248/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "b3fca17302e23e05a361252b08b696bc9b23d5ab0fe20381359a05477d4fa08f"
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
