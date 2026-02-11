# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.62"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.62/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "73066c1e0bfcf03bd161477b55c6bdd41cf6e9881b9bce1d51bbe4df9088ce33"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.62/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "07a5adbd04afb34e59d2b3a67fe8df4ffbf64b7697a9f8829f4fa29efaef1f6e"
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
