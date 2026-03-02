# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.89/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "9a4a35e3ac167e1bdcf6b3c9c4a7cefe4043cf57d478aa9c03e06c02592557f6"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.89/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "d9af40a8eea9fd34aab62e845972f31373189d19e3044194146bf7c836feb1ad"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.89/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "5c4590612875077ace2ac2b39199486f1a76cfc750d19e2e05d6cc119463b841"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.89/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "1d858c4323ce2d7350885523ce81b4f8af817116355687119bdea0c43e484d88"
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
