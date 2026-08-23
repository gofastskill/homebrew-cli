# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.186/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "77769b86351f12a25fe61caa0b63f6dd9bdf7d2578294c603d75ecd7c3c00a1e"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.186/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "283d1c078e2fe840141501460d761b4446014aeb9edff819c7a88ac4019d817e"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.186/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "c47a42c834fd4903f9be435e01052de5250af934db51553203515fd78e650b51"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.186/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "1e79f8785a5803bdcd88f98583b49264e9271cadcea8ac974802bfef033bbb36"
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
