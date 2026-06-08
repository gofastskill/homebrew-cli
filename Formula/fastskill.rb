# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.136/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "321a26ab9b388f5e63e9488e426b4b27bf42df4a3b7d0e1387361b70f08dfe9a"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.136/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "d813e87b4ad2aa91505eecad28e8e1b58b62bbc39ffb459f91f1bb1789e59ae3"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.136/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "a9bab02e9d833ab3a4275a7d67bd79971d35c2721a68a6dae51e3002fbbf1117"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.136/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "74ece8842817c9f29f448530bc05ca2430053b0c9d0030c8804872e7d64bcc5f"
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
