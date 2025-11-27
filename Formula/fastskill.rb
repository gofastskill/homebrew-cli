# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.7.13"
  license "MIT"

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/gofastskill/fastskill/releases/download/v0.7.13/fastskill-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1f0ccae7a9a6f8f027be0c251692eaf5fc2b1c9a543d527b683841e4bd2a6ca6"
    end
  end

  def install
    bin.install "fastskill"
  end

  test do
    system "#{bin}/fastskill", "--version"
  end
end
