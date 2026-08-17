# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.172/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "daccdb361c7258db116b90eabceb7b33487add5ec17801b58a36a1cc8bd711c8"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.172/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "8c14fd19ecf47c29fe3c70ff1a57f7cdeaca39341af751fa07a1cf6b617f18bf"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.172/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "5004a1edf0af0489847a23b253af6b23eddc2aa358a35fe43ecb1e7d524b2cab"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.172/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "a04c495a6538c3ac5a33ebf9897e37a7b31157ec8d7934ff831d6254799c87c7"
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
