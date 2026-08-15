# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.159/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "46d8796be3421cf0bd4217bb142f320258815cba6b99301b4e8747f55e29e5a1"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.159/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "48ad6411cf1732c912792adbfd50b5164953f3e0e5e73bd3b3319d66712e4510"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.159/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "cd12de2582b875483aec6a897780fa344b1bf7b3b38cc87eaf58ae002583fed1"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.159/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "491a35864e7c297e9d081e66a4335e573920363407907224064b61bc7773d112"
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
