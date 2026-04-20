# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.107/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "8b16e35e0312f92a90eee284877fc1a9a33d6b49ecb4f33a78ca124db7d964b8"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.107/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "d40aa9e5fb9f9a25ef0b47057a510069e71b15b668ce190756ea26b75e5da12a"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.107/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "3c8019e4b508ea61a7a884af65d54adb978c3c1e30e373e833ad11ff182b6d01"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.107/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "dc5959ea4017ea15239a4653e7af295dba413c5fd42a584a9d2a703f1cec1be7"
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
