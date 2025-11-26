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
      sha256 "66b5d14600c607618431e851dcf5f19be7d602eab94171237033073e442ce945"
    end
  end

  def install
    bin.install "fastskill"
  end

  test do
    system "#{bin}/fastskill", "--version"
  end
end
