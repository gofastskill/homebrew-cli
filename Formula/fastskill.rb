# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Fastskill - A fast skill management tool"
  homepage "https://github.com/gofastskill/fastskill"
  version "0.9.59"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.59/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "5755b15141fffb225f4d9c3e454cad3f1e42f556eeda2dc75ae789f533b23d7f"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.59/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "f65ae533f1d795fc3054bb5b08baf92783e455dbd6de63066b6616e3bf246d56"
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
