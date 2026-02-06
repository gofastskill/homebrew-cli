# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.46"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.46/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "5e817f248f41c90a4d2771334efec4fe30830c06e88c48d83f32a60168a5918f"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.46/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "56400d2ddc884bd7fd625329e9ab72537de1e5138edde9379b35365876510739"
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
