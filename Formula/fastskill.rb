# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.166/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "ef1a7fa74a6e3bd454cdeda2c8b01fea2b513b2476f9e93982d1617a7738a995"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.166/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "8afd3ff554187caf9bc4d1e84626d23fad084f580476d697853281c337b710f5"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.166/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "8a46c49edf3f00a26a520f754e0f463dcb3117311777ecd06bfc9a74a0419c09"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.166/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "c1e4db4cdfd9e007b2822a99be9ded67585dbb18638d3695246159cbfacb9dfc"
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
