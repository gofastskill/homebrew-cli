# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.100/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "443e0285f4cc5c66c961b3dc8a8787c7cc2090568db69c49423d9a2542f78579"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.100/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "234b7cdb7f9bef752c42650438aa8a69d51c03ac488174ca2f08d98b3baca227"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.100/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "8bb70e68088aa37682eb94eca2a85b381ed6b2341bb43130b02928482c2d7634"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.100/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "593126c07bcb379a2fe0c80f5e94fc5f73fcdb96ef67e4a50befbc37a77181ec"
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
