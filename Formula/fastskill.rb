# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.131/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "906fcf43d490fb68a422d9f47f7ce062bbe5257d181e48ed500617fffeca4e7f"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.131/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "60e2348f0fdf9af431d81e3f88c47062846189d2363de4cf8e946818aa8babbf"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.131/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "6b1a696cdf2bb6cc9528fde57ed14fe7f6df277a5ff742f85f3929b89206223e"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.131/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "8aff12290beb9ec618dca737597a20d3fec88dba002d46e1304a2812879fb70d"
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
