# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.158/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "ef06b11bb8b2c7b76244ed2e67c25cc15b6b55503b4ecca86f0c5bc030801475"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.158/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "831a89e9895be404a59b9de4a57d9cad5e3d534e647de402b0728a736555d36e"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.158/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "a4a9838f9a34689a7a68257686c11c2ba721b914f45e8b142e366576d29c87b4"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.158/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "951e1e98d11e5203275853b9a2e9c331232c7ab2ab86a6c86d466fd9636dba3a"
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
