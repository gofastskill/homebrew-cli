# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.109/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "b0da878ca24f48291ac624b1b5533cd85795b9c5a29386678cdd60547df947e2"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.109/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "73b74f508c91fd451eb1ee6d36a66ddcbfef39e6ad5a186fe34d5159962fac5f"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.109/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "c817c5804342f30a3aad83b552e242fcbe2ebad66effa4d41e040113b2a5517e"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.109/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "8e7e5ceb1002dfc1a9cda51dd50014ed73153fe7742e1bda476eb2e4840022d9"
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
