# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.160/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "6cdb484a662d5a811e7d8ffb55bec845700075353c20ba21121e65b055a79ce1"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.160/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "3271bbad88a943699382441b9f2a520a30c4ef4ce36c597af005534cfe38c54f"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.160/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "bd07de40f772b6a81e6219794f0aed100735b886ea936c369326a4c0c444048b"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.160/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "d9a6977a67819525b9780db1213526227940951fb1b2585b88d1db0e96d591d2"
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
