# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.14"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.14/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "fbeccaee8543ca4e38d29e7b4866c971aa9bcecc3a911359abbd4e915c1bb3ec"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.14/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "03114d37b733b8adf8d789a10ca02232bc516360fbe334680682e90464539df5"
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
