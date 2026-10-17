# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.275/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "4bf3cd46aae26b5c874bfb00c40371ec345e658454653c9a964e115654d17598"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.275/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "073e9c03fd88a99feeab938999cd4680f19f1e60598171791a7ac222c87e0888"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.275/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "751d424071ee18618224595f89b75a8014a471346c63a32308a809e1f3ca972c"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.275/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "2cd1b33d6a2de183a6a23f5b9307f06eda61a3ee3dba092fdecd5d293cb4a9a6"
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
