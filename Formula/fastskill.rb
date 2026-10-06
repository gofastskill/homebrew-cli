# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.263/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "931a06ef136a1245f108f6574ffe09077b14ae88a2d01b3d106b8b63f8d2ff7f"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.263/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "5b259805c31edf63177fc7922685b328a3e31835b69bd80e7efab834acb845df"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.263/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "4a090bc6ab72d2c1ceec1bde654152f2750d5783c6e8869b2dd235e0520f6146"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.263/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "90d34a666bc952cba763d6e1b512bc39fdc8d5399b4e625c498db94d0e9c36a4"
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
