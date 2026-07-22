# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.150/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "f357d41b5b7eb6b78f5d01fc3803a29dc6ba9c42ab961ac64282be5603b4854a"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.150/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "5d0d018015a32fbeacae76d63d72631cd679d715e126e62466bc763260dd9630"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.150/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "60dbf74a5f341877e96d8b4f1a098d451d9de174150505dd80bd2a6bf98be9cd"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.150/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "cf712014a785b670e96a4ddc12ef8dc13fff5cbb6150c90bdbcbaabc990ce437"
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
