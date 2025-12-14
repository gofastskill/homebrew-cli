# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.3"
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
        url "https://github.com/gofastskill/fastskill/releases/download/main/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "8d699f853043e62be9e109c1ab3d76af54a0edbf6b682312bee16b7182802361"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/main/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "086d83fd1e68572a145a083f2609e7850f635bd48bc9770ca89ca5cb0c1f0a34"
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
