# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.25"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.25/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "f964c52c0211576687657200cc3bdeff1be8d39d93ae0f46527b0b7a36ef6fbf"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.25/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "d1fb3a26816ed0cb3c619fd7ccb55624da8405521b3187f1d281a818f4b6e8da"
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
