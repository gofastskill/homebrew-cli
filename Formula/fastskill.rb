# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.214/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "0cfe2e1e631f5fddddf30bd5906293f046adbfdf5534868cc4a073c7a3da7ec4"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.214/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "cfbae94c445255c303522674fdd05b3f0079327761afb828f91d5aac5b4da133"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.214/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "50bcd9aafcc8853bd3db8dd3956f9faf12471c602c090d386b930ad9d0fa56e8"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.214/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "22d16080dd31291f80a37a3b70eab8d70b4ed4c34e1d71d7620c1cd89bb0ee48"
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
