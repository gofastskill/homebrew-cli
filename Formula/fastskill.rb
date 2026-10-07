# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.267/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "dac110283261a8008b1a61fd288f520cc2028fdda74437498ea208ae7a9da7f1"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.267/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "ce78620f1a93f1269230f2b3db37dfedbc3d85c9347797de3105b59d3fb7396b"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.267/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "a8f058c9666b96d1b44386fa20283bf693e6adb8bc664414e11ea8425e2e3ca1"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.267/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "7cfb3cda04000ef937f47a495a8e987c72d0ba7633f6e551a5c7e8bb4bbf4239"
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
