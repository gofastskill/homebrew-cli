# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.268/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "5b29ade6d7548d2314bc534cdcfab5ea815fa0d31b888850137ac88d713e9a80"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.268/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "5cba79ca4b0797efb1580cf9e53fcc32300709f3ad4759721d7acc7ef5353227"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.268/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "231ea316973cb1b97396a974dca0f992685b4bc7cf53f5a6710bb0e5e22ba339"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.268/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "580565d799cfa65a09b7807ff824b6acaf8daf8cc8851b6fa41ece798f2e86d4"
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
