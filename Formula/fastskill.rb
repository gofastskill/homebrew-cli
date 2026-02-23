# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.78"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.78/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "51f0b54fdbb1103d91d5ff65498cff09b8b4ba0364de5b16fd9a6c1ec33e48e5"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.78/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "d22c738da45fe0eee98d7c11663d80a99c3b525d82789bda6079865bcc0ea793"
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
