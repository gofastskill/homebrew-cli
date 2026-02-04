# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.37"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.37/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "bb5a59c933ce00427d5a69d12bcc316bbbd5da1a17ec755792619b5ce02e7045"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.37/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "bc68254a4600e50f4455c9a890e8d3fe2db35c075db073f717faa73a575ca9fc"
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
