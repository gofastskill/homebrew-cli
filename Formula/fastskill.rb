# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.270/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "1b68e4a940864e3d4f808399a0d0718b18daf290a3918bfcc3562e75a19cf8e6"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.270/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "2973e019c81526134d42d15125d8737e9eb0e3a3cd2ea8333775df7ed35859d2"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.270/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "9cf83bfd07a033b003a621cd683f3a8f187b2b8a7b08a9dfefac38b7e7dc141d"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.270/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "6c974f2cf0f5a6f800b1fd9bbde09f7b3dc95b22d14615f7121c468f2103a0ff"
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
