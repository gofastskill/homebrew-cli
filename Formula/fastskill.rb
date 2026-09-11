# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.230/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "03a892097a02e794d389e5a30ecb7f3686311d35934f2bbf1ab3b989b759e372"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.230/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "f841fecfed88529b205f526ac5005955ed4229504d3cc24a2231f11f745ffa2c"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.230/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "fc57060de8b8c2f2986039797dbf1a74b3edd36b2606a4e1defaa9927bfafb68"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.230/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "db507dcf8a445a308d60b0cd7f9dab4afab5d3427e121f2dfab15faf1e2b1dbc"
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
