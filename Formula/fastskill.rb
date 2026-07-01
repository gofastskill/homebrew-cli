# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.143/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "096fda6e35913c92c5af4637eb26c0ebbff5696081f6bf2cb4375ed5cfe2cf70"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.143/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "02a171216868d7f92e8ff7614124bf84e5f35779511bb18e4566346b48a3d96a"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.143/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "116e033e7fa27a23718529e40d154608f3818629f48c02541896b1abb92847fe"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.143/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "8293a77fabacb8611b84f300d30645455fb4cb5355ed72892427b1427cf1aef8"
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
