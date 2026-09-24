# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.254/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "553fa60f9db026d347d59ea039ae8ef5789170bda08e22c7071a9792514f914f"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.254/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "f9b4d19dd46ec5ef02dca25419c614633ba219cb6fccffaab542ec5785010f10"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.254/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "e936c1055b244ea7e3af50d261a33918fca536b24a15f562017f926023deba80"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.254/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "da651d13bfef8c63fd6a725496042b1a2866b6433a3f21b8f8c6bf7f01f7887e"
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
