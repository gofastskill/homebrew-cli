# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.55"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.55/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "a688e0d1dfed529c5e0192be6ce8482bfa8e7a68e46df760b92da1eb4b7dfed2"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.55/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "54f3588b2e474f1ff28e1482effa8b8a58f9d31b132c762d3b339c4c4bb59b10"
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
