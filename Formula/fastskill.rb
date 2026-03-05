# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.94/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "8433ac3d191a233f0dd2451309d7faeceb529f81bcd7a271b0b72e19f3813c9b"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.94/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "51ab082d7a179f6db4409a5577f0288863c5bb35f9a623fe976a03e3c76eee2d"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.94/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "3d74edc2b65cbec38751b3500e90d47e3d60a097e7658d28fb065a1ee71e3692"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.94/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "8160b04d02e37986626bb7bf3774f1aeef1c5f7fded1cb31a4cf50569f7cc3f8"
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
