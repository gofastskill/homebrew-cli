# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.97/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "2071b348c1e2b9ac44c309a71d7c9737f9c6c5c2b15c3065619df380f80946c2"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.97/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "48435b63ba7ad549a68c67bdd145d2a9d403452f1748ddb5e93ab49ac60632af"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.97/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "230a96f7b7bf127aad697bc27bbec577287ccf5d3bb2675d1c7ba5e0fa17526a"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.97/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "2beeef08ca2ec56e4f16562ce3efdf4d1e29f54647196b00ab84adf497252e69"
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
