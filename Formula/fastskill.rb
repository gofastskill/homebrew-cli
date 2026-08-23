# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.189/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "67f15bd1eefe5d4c8808323693f788151d4c348113a27760a399ff9a1bee7059"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.189/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "a74f6877abde2321ede98cd4622dd272d32c8349501f6d76e2a19e057ef24038"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.189/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "3271c0d7b9d7d8a306ea0ee9a0e816fcd3583494bbd3d89586ef24ebeab9fefc"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.189/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "e1aa4a899c0e4f04ba353d480a797eaab7d8874c214404951bff67365e153d5f"
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
