# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.16"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.16/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "5172ab7ba4263dc94ded3955d0c507a2355d7ada328c2ad6fb785392115e4cc3"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.16/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "26a45b9c54906cd1ad3a0ad67efc4f2a2eaf24610ba1b0fdfb79efe9781e6854"
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
