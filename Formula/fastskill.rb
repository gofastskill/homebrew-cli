# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.168/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "2c11fe5017ebd6eec8eb57e612462244a83df9e5bd1844344207d6aa2fa2172b"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.168/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "c7b6a83e9ec0fa8940d03464d9c562605e98ac1948f198d8bef76c6413d7a0fb"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.168/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "c42812a0de6fde821a88fca50334e3d88efe985a5b8b33e8aed2020f7eb40151"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.168/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "e412635f71e2504c8b3368a8a899d1affee0dc82d0ce7a8cf1aa2e92cb5aa791"
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
