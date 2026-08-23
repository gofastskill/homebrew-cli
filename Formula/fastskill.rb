# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.190/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "747c49ec17b820df59517abe77815b6d926662d4b5211c6ac8f367eefe23a1b6"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.190/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "4751cefee8b21f5684ff17f2ca75b3e8f6617ee66af60de66ab3f87ab43639dc"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.190/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "adc574344527937a19a4d16c5bef60808347467fb0c0e81542525821fd34f7b4"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.190/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "fdc3a8162f463162e80cdac8f8d2ca12df486b337d835f9de7122e1b5c490bc3"
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
