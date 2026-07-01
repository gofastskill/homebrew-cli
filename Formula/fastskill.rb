# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.142/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "581647c0589b0ccf411cbc1fcf5227c214e5b1a2ede961089115bd6cc3013498"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.142/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "95134d902c978e6ec25c6f0036b7c9b6f30a21dafab94fe9777291c1931c376f"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.142/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "af4c1722dcf09851663b6b1548296be6a373df7cb9449c6bc1cedab3a9f7c252"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.142/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "884529e2dfaeb4cc9a0bd9b1c837612d1be65be5ff7d67c655b678838e252a1e"
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
