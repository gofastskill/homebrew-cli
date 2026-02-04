# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.36"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.36/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "bc29d0c115689ba54a695a9a274c1e62e2a4f8a96f9a95d7f3e75637d971d8c5"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.36/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "df6aafb21603766c1f28c3758499b4763d7d5cfe0f1798bcbba3d074caf7f183"
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
