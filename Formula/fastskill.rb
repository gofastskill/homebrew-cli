# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.93/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "2029ddb9eab6b11fb83dba7874c2250a04bf243b1172105d834cf689982f2d28"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.93/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "b81fd7996f85d2d6e46508f62ffa9a1c90debd70480ab4cf8100d03787e61e2d"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.93/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "316e7166a46d02f14372f82dc07b5d21f363fd24b1a817583b433bd8257e331e"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.93/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "704e8943d586cf4cdbfe5fdf21550123eeb542b4bec6075a57e78f99f62c0556"
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
