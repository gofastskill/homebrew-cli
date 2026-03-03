# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.90/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "e71b8f2f2b193041249e368b79de8e33ff87862242839524a6fadb4aef75d654"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.90/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "5bb78da6095f28a753b752993b03d08b4a5f61958cfe5a56701290273792ed4f"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.90/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "0c7d2e852a6c42a1eb476b42a6caa5a0ea49869075bf77c6c2f72e34c735bb79"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.90/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "df5287beecca427401c2a1441f3276798ac27e32013fb35e8ab6adee34a84ab0"
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
