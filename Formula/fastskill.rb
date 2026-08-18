# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.177/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "02235682a79dc1c6c9bf9ae76c1fefc276aa67815d4c67ad02b76ccc193b860e"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.177/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "cc4e837a1646356adf8d184ec30c27646e013dc7a08ab3d875f1aa4e090df036"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.177/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "9a836b9ef06d1f5ab50509c3d7e32781dc8d0ee6bddef03b91a5245fd16b8b4e"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.177/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "3dc295197e324c0e837451043ffee3e194f828562739a0f9c69e45ccca869db9"
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
