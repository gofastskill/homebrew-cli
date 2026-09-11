# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.229/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "1c9618199d92226c979e84ff0e0ebe28055db2b46cbbaf6d267c5d4dd73046b9"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.229/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "9a0347b6674232d9d1f5b9bd8d2af92ccf7bb056fe489bc4da4d56e97baaf75c"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.229/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "ec35276888a68a9a96573c5c2e739658d873f4344a199b41480865d346646d8f"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.229/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "041e1df8da5c122a14458fa859dad7dd8609de292c6f9379b7253269398ed968"
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
