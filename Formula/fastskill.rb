# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.233/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "b5ba3409e58dc48cf3359d82378fb744a0b20fdf0d67c9740ece92645fc6b186"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.233/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "af3bad3fee5e76fc794c86e2b34dc3af8d26ee6de0551a9ce37370a3906ecaba"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.233/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "b266c88091a3e2731462b0f92a70ee95fb590ad9c88dd640d156383a477849d2"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.233/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "084e1c0eafd81451efc3295e0b5e91f44e75422ec2465d912b79c50d662e53b1"
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
