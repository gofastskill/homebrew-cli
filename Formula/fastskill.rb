# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.156/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "fc6ee15ed06ac74dbbc426980b569bf0c5dd079b0857ced4f76632e09ac8bc92"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.156/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "65cd8cb2a04dc5c2c69f94610a14d327833140d3191eccd1f909ae9b8ee85452"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.156/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "86c451b9f5015b778e2e1a7fa6a8b6d00145098807821559ebee3242b331a351"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.156/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "ec19e0a3d9b641dcc1c4e39d900c728d8671b0dbc80a9481ee2ebc5482957696"
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
