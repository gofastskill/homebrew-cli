# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.154/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "3b6487029544d22e534fcc593b349dfb2f24d17710011df6d75f421f0fd9a52e"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.154/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "093f22167adf8e477e59b5a60a4d1d5a93d652da63c0c0d12ce61ddc50569799"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.154/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "4a4c388f68174d93a810a62014a72e5bfbc736e54982b562959500645572b8ac"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.154/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "6f43b793ce4c7d976f5c1b3415db2d88b25364e40d6f7cc7c9ce53da602047a4"
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
