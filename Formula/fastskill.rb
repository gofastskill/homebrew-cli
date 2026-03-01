# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.83"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.83/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "2dbe505c96a6d8f68ef073a662d405e2dce91ce8f831ff7c8aca1332a45fede4"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.83/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "15d4a315efad59ebaeaece65f9008c4fe1b0a4e614397b24bf2ad086fb4a8a20"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.83/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "43d0650e80771fef64c1e1971d6954d7ce55b657456242bb39948acf53eff1d9"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.83/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "45d4912f9ce3a9565074a50c3f4bdeb94f44047c182f3c1b73811ddee22179a5"
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
