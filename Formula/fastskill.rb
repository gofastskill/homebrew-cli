# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.57"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.57/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "b067f9d02e2a967e1a938e42a6ac5ca07d01464977683bf2683d4830524936b3"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.57/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "d5a60901bd827afee9035da93102e69535a6ad56daffcd66c3690c4a0823eb14"
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
