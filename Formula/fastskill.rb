# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.244/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "56b52b2ff4abdb5f493861e759f3270038a1b63f530b423c8e3e9f14dd50eb37"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.244/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "cc05ea8cff79e3b03f0e1d95a8990ef7814540a3fd6eeb5c678c42fc0820ad52"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.244/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "f5d40d730a5ce7b8aa2bcc23889b8072a4daa2c7049a32a2e24004ac73671453"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.244/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "fc7f397bfabd23752c3043b65abe01d8b4378311df9909edb0d9ff7e9666e946"
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
