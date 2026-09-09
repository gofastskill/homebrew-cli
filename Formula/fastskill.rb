# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.223/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "1618f5f2c7076a1e00e5d1eda7076acf0647f590efb44302e026bacce9e5402c"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.223/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "d23173fc0d475f2523fba013750b1406be71abaa4fc79d8c9d21957d88d2bbeb"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.223/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "b9e488d5aee75549e075209caa0cf926f88383a4df5d0c0fa06c336d9f8a8d0c"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.223/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "298b52b5e430be54fe5672b83297bda90ad7f5ba825268054c46f1dd300d235e"
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
