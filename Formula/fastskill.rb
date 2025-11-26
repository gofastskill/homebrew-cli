# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.7.10"
  license "MIT"

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/gofastskill/fastskill/releases/download/v0.7.10/fastskill-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d5d8dd7590e5fd9afa3b15b36750ba2de8aedecd4cd37348e4a1242b9fca9d55"
    end
  end

  def install
    bin.install "fastskill"
  end

  test do
    system "#{bin}/fastskill", "--version"
  end
end
