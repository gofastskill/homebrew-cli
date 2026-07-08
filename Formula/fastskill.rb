# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.144/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "9d505c9a67e396072bf7ee716c55533666b3b9dc0069eff31126c9a664b9506d"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.144/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "a65d2d3527e8e6c98d0e3aa132961d57306f9720fad3e6f16cc206f2ffac61f8"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.144/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "78d66e0e8c8bf4ec0d922ac9ad34490b324cde9d53352e873e0dd3c27b7b7456"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.144/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "811b21b3d2f077093227c0c669d215155cafdaf6e705118788de93b45610fb5f"
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
