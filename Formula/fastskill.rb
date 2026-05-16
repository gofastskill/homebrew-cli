# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.116/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "351726cc486758d3a0617c0339d0951d59865cd1421bb976e1073061fa61eeb8"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.116/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "94e5f5a93c5ea258cea7e389378a7319235c67de58b5ffc29f6adb373bc698b5"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.116/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "d94c742f2f7bb7f87fa758e8866e150c6594b5c4c71fd11c36a6ff4602d317ae"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.116/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "f2b1e407184e86a61406636de567acbfa1c9072db560cce9eb8f97e096e6452f"
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
