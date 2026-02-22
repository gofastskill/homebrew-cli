# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.76"
  license "Apache-2.0"

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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.76/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "893157c6a552f67149ad86d924376b3f9805c735267ea911598dfd14423d0696"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.76/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "bb4692aa09f136d8014fc358e563483285cd3290b6e1223528daf4ad197c64d4"
      end
    end
  end

  def install
    bin.install "fastskill"
  end

  test do
    system "#{bin}/fastskill", "--version"
  end
end
