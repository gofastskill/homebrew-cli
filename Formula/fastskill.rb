# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.110/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "80929ea32febdda2a7014fafec43a106042b83b63a79f87bd7b5cbecabed9190"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.110/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "e20bd004ce6fc8a55d77733a3fa36ad08c16f2fce64c374564cafe7e313f3afa"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.110/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "554c557a5afadb68c166f02411550c2e2785e194b31d1ea5a91d4aaf5505c670"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.110/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "4e7a6eb789d10edbb940d531c40e71ec2c62208b8edd201092ef94964569c5ca"
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
