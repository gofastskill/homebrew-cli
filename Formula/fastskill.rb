# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.88/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "8cdd5d7a941a40b8b62fcf78fbe029e4459b1cf103d81ccdbbca87c7077575c5"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.88/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "1fe37da2e3d9658dec1e39ff5f6fcca2d3cf317b8b1d9d92cdc9b282b98c6e95"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.88/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "e396a19e3e01bafc46ba17fc943da4049bc3312b22de40b32f34c28a979d4203"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.88/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "1fdac3daf18174cc20c10b5f1a9668d11848572114925a3a1e6d741567acd439"
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
