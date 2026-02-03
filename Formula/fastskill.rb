# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.26"
  license "Apache-2.0"

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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.26/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "9e53ade1f919ed77dcce894aea1e34ecd7e0b303368796683b0d0a357296e962"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.26/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "74753c94bb69d7ca50f20f944d71f281fad1bd67526197614dbabadf7e88068a"
      end
    end
  end

  def install
    bin.install "fastskill"
  end

  test do
    system "#{bin}/fastskill", "--version"
  end
end
