# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.104/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "4031354436d01b9dbfec117262e5a74c4d9e5c7fdad1afe3f2d9d89ed269e949"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.104/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "22fd9eddff145b0552cac7adf4d35bf54210e1cc4d37652f3bcc45b0621d681c"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.104/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "daf98dd53d4c3ebda92b9cbbebfa82d9a3f70d48f3e7e0b529318e9c7fcdd3fb"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.104/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "9f615dafe99ef07d3e3eb4179b542dd5e0dd9e8325c860fae856d51f82e78336"
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
