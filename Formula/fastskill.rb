# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.277/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "966cb38921e4e9a3ed05fb56c3e39f09092c7a314140731b5a5636a6121fe1fe"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.277/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "b106ee121ae558302edb2e2342946decc3f1f6855bdd11f2f66ea7ed2a86547c"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.277/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "b732392f9e16c8fa2789da69fc4d087af0e4aef181d035b4f426ef2e762bacdc"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.277/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "6bd089c22983a75761f2ea27ad8e5ac4d4f1f49eb0d9838289c18fd0156205e1"
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
