# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.175/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "ea84674eac9d53704281c108a71bb2df4040a458db8553a499d10a953136f731"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.175/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "823af486e0364841190929dadd8f18def0f8fadf2239a51515c6b720c8e8112b"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.175/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "bc0334d321273f07b7a39202050926911e8a0963749c9fe155f76cc6d92a90cd"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.175/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "58326797f077f44c28c2febcd2358bc06cb431b828eb2fbae7f21b38c8c077d5"
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
