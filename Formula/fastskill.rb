# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.184/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "cf28ae39cdd3a64b7a24d81ff79f524302940d9b7e412115ecd10567e56ef095"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.184/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "6bdbd41ab4ce1c8cac2b45538c42f3bea3cf49dae59c4522af09e7fbb77da890"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.184/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "3d0ff256c6771816ae8e8e0b55061f242a4e9da20b932c97d76c1a4eb755351b"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.184/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "10e35c06077c929d07eb488ca1ded7065532acf398b4e8bfaeab10a6023a5302"
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
