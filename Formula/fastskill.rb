# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.111/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "eb993f82070b749c6daef97e42fa93b1801697390bcde68a084befbafb6b64e7"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.111/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "249b9466e70c6da20aad07eb9564db743dedbeef7ea6cdf851eaf0353ccc8fa4"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.111/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "c6b132823c0aee761f9501549133136997f6d4cadfcfbd2a1455e258c8390383"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.111/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "c386232ea7c9d46b7700a161fdcbc7722e5e1a46b063751c2cb92c2707171269"
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
