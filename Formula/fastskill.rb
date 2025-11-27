# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.7.13"
  license "Apache-2.0"

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/gofastskill/fastskill/releases/download/v0.7.13/fastskill-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ab4a1791e08f4a144eaadef83aab4e312a5fee0bd2a169880ca85966f6f730b4"
    end
  end

  def install
    bin.install "fastskill"
  end

  test do
    system "#{bin}/fastskill", "--version"
  end
end
