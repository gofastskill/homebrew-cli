# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.241/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "3871f476967ffbd272566b2716a5d9c2fd9675df902d9c87d9e81316e3f68a8a"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.241/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "069727c8a993b84f5f898e5d8baab5f670bcebb92e77bec558ddde7ffb2be2c1"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.241/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "beab1022b52712e1c492d635773d9e4ede504fed3ddd50c5162134c92a709a2e"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.241/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "8b1a90cd65a78524c385984ed93dd275151311307ca120a76726ba4ea6d3cd8c"
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
