# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.261/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "878068a22b1fbb44ee84d59b85c7deb7090e22083cc1cf1d82ad56c3468ed3d9"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.261/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "fced35b12d665fd687e61c09b63c7f2e571814a4d75f7347f03d9ced806b2c2b"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.261/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "27d3584f5fa407e5b7c1ab0ba1e4a5a8f768f86bdc06208e30b6e945f6acca27"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.261/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "40da24e13a3aa7b08f3e87b62480b2ea21adf86b58c1fc72a61ab975e0064c89"
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
