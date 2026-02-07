# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.53"
  license "Apache-2.0"

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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.53/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "3dd1eb7c06fcee19ab8b07f305dac0977635baf1d5f3a30c08b2a3fae81de92b"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.53/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "c498df9b96ae5e186eec8817772911fd32dedd3b0c2b0a4ad20f2f912dbaa46e"
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
