# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.262/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "adbe97567b895ce5e8863d478cd1eaa4de358eb9782a55d405312e133e33d383"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.262/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "6d39b47387c1c5aa94c30b1db8b03019d4810f28ce8571b9595eea084770790d"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.262/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "0baf52ac1ee0425f30de8ec244b0bc581e2793e282960de3a0f64b6eacd65369"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.262/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "95d32bb805a3174ff86689a9e81a85294dc337595bb0702d8a9d6c68dfe7805f"
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
