# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.235/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "f66a59002cf77395ccc359aa70707c615fda8206c60c4fb5c5fa34abcc4c7aa9"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.235/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "5e657f71c96a51583374deb36e90e7c4cd6e71c082eeb38622d2f0cc0500327d"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.235/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "96b1e55860f90a19a639561e2a1c1297fe9c4c506374e2ef45899b5fd8bb6164"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.235/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "b669718bf9974b71cfdcd6881bce83e4f10a3038d890f58126ef711838f349ae"
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
