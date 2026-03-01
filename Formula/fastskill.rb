# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.84/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "2d74a1f7b733e8e1f289ad050ba540221ebc993d336c706f6e33dca17b18fe0a"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.84/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "24b142f48c6c927f79d86fb2495a200cc6b648cfeec765f164660130a8bb00be"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.84/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "d73176bee17e354d7e2e08ae29a4bbd7a905efa93a6d4955680e4ea538985a74"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.84/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "679b90609f1797bbb9f5e3a38dd456aef2b6853c469ced3c66bb93141a526a64"
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
