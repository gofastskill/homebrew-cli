# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.69"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.69/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "bcf53bd1b60714d937aa2c602b368d4460274930b7c6dd4e500d486ea93cdade"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.69/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "f94a83c4b44df95999e8d758a4848591ce413a780afc887bc25ba0f546efd7fe"
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
