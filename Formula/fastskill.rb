# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.209/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "a3384f9df2aa957c2e0c72733e63de11e5566dfb230e13976c173351b9ffbf64"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.209/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "df36aaf7923100e4ee56cf5f7bee1dbbf22481dad36d92464f7827b5c4c00edb"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.209/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "27005cf5f63c1467eff6dd2c3ceb2b7f9b510d4aabfb5d1a86823d1d9b36dfb5"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.209/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "65ad1855c9f62bf35dcc1e96eac523335e11228f74458c4010c7c798e5bc39b9"
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
