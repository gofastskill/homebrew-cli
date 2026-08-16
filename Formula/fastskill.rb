# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.165/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "0346a8cee10a187df0ff01668fee18394b94a4ccdf6dd7a8497285cefa870bb0"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.165/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "dbfa818946188490e7ff17649b78574c436058e60b2499951862dffcd7b1e69e"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.165/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "350cb514d9f87f5ec4b0bf1f13a365ebb439728679621351a6fca8e323b35acd"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.165/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "935ffebb727fca6f4667b6e209b7c4e0c826e591285d5f6fb5a6b7ab25f44558"
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
