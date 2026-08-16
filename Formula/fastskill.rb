# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.162/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "8d10dfdb3fbc74805e323d876df3db5f0f8483e293c4d87e417b70348e29fc92"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.162/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "2a9f941834e9bbd562e04f051c7ae76168105761223d1c8a36307a3c1911518e"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.162/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "111d9ad52b4ec65cb7b140fa02be142338b81ee796519ac17cbbab2a8c240c27"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.162/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "fc36136979812d86969821bfca5ab2917a2a4422cab47106f0e82e1b4a3ffc46"
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
