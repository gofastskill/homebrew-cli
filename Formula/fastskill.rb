# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.84"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.84/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "145f27eff3f53788f218e26a359d2728a6677f6bedf63921542782458b6352de"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.84/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "5e6164bb63d15b6f2e698f54914971dd01ac90409084e3bd2c1cf42424c6347c"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.84/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "a658fa83c0be4db3d0c5b499d745d224955f4625fee29cbb03d27bd16fd47391"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.84/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "938c6e67d7c6c31cfbb51ae3dbd151b07a20841fd99561667a804f9f581c9edf"
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
