# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.211/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "cb842980da97d93fadbdd2fb9fa0e4b2ea6810a892bc8ac4142913479e505634"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.211/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "e177ffd1fc9bcabc3683226bdda6cebb36a05e16a3001b41df86fdaaedcbfbc2"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.211/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "e8ae3dbb6d38075fd4c7137ae5c75a6155e5c580a5069bbb369396f429950d8c"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.211/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "5c3a37fbf2eee38d4f89e5212ab781819ab1f8ad978dc4cb11ce84d570f83bf9"
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
