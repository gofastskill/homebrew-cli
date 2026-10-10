# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.271/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "c867b8825a1143344a7c304f834b16a865cb241f877edd08183eb4519147f345"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.271/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "2fd665d1414d5fb548cb7bc19fc87ae0bd61881ffb03de48b8f43d5eeea7015a"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.271/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "89526cb952486a24b1df08d3e24b2b9f97f5a44949ca4f2cd712d2474a3e6135"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.271/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "18b5d9a75e8d9db9c3a2ebb49be1beb626323b60c5e28cad67dc93f1466297b0"
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
