# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.101/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "21c794dc1efa7778154fd382a665fc578227dccd4b8b558d59f14fd541a1ae5e"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.101/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "fce946977ecf4251a688bbce8eb5436840784969151aa1ddbf8b483036ea7c71"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.101/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "3a7d6c1858bbdd262a02a55492bd4867283817df850fe02ed663b6f05aeae4a7"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.101/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "06d3214f82d6081793d95d6c834a38b2b1738f9554257e16372985aa72e3c754"
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
