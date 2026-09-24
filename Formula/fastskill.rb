# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.255/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "1ef2eeea0e70fd9a52cbdee14cc933808428af148003f3481218865ffcd58164"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.255/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "0cfd64a131803d44d85f02d6bea67fe86e9c232461b9da761db0e5615262996b"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.255/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "8df93846c89bee4593a1c981e3b99b56c8d161afe84b0208dc6996cef6641837"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.255/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "b7c71769ae8c705445ea43ec08f296a490556f1d2deb4a35e158774b9dec4b43"
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
