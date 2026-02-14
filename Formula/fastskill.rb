# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.72"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.72/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "6a7666a3bb27ebe0ed25880f80d6338f03365054a5580adc41c6ee6844ae5679"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.72/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "2a7f4846dd1a4f2765d25ee839ed0510c5c2ea1556deda8357c013851b836f1e"
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
