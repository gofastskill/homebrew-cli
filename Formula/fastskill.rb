# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.133/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "19e63b24d643bc6c76ab78330e54452b4d219abfc3e46004e705ccab6b8114ea"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.133/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "12fe39b232e8fe3de27d10059a788c720208d551d5cabfa73b0f24188fd20f6e"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.133/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "21688a2e093f22fab71a28f2b7e452c60fa65c7ca094d54406674af2614d779f"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.133/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "74907764f0fba8d1036fb1aad7768d85be9ffcf6493fdb42287737474d0bbcb0"
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
