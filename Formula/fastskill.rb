# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.252/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "1608b1017709ab2aac7ef50d19b8e919d1077ac68501e3be255e52350e787cff"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.252/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "40639210d7902338e4641a82d8ec10c9ef8686beb0a37872a3009262fbb7a58f"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.252/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "0f523281f992060f83289c6a2b2e21c893ca3bc80fe1ff3d9b5370c7a99e6170"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.252/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "bb7b37745a95dcef38747da4f29edd2ac68d7b1208fdbde4b5bb6d8a9feb3f33"
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
