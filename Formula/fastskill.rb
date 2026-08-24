# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.193/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "dcbc60ba406b61971cb954abc4831ff7c1aa6283210cadc2f3520d46a5df3483"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.193/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "0876deb29050cb11bba095da410d0408b9e9c78486cc68eaa3cf1691a2afd2d3"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.193/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "4a34bef996ad3cf65127bb95b54b591db7d486050868e4824c4ba553934a831d"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.193/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "8af218262fc56dfe79eed3140c0be2b5fa475ec7c0613692527d5b915def73b3"
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
