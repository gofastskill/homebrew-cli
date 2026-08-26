# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.201/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "7eb4f89bbe85de7534d0345f2036358c28603ed675134795f69fdf839dc6eb48"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.201/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "f6b296aa594f79578bfdace0ee8c2985262999fd7e8077ea1d731691524d9b3b"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.201/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "49e0c5d54702c82684807085f8f2a5e28c9429befc72a08288d7aea321743496"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.201/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "8a4ac96ad3e58df5bb7b30aa2fad64c175f9e5d10d7490f2b73d2af476cda686"
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
