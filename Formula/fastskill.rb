# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.112/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "4dac8b620cd965945206884ded948c563a4a2933ba9ff1393f83f830f0df30cb"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.112/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "e60eab4c43a1c750030bbfb53572d54b9b8fbb8de45c653e0763a0fc70dc8657"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.112/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "b36ea0092d55e453253f6c8e20a51c847fe585d2329103780fdc1cc13b343aac"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.112/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "7934711129b0e509535ecf301c991d51a16cd5ddfcc380caf6bd2152bb5b676f"
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
