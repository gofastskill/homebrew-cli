# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.221/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "e1b078b9438b0ba88a0ceb5a471b4e1619a8c7d8dab3858ad9893e3086135853"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.221/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "8df7bc0cd314e58a2d06ff7bfe04ace0d1ed285e2f25beb762dfd3223c7b86b9"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.221/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "744d13bc8330ccf5438854cac3f8038bbd7f654c9a949c373c1c561f905d9690"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.221/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "4b1ba3ec1a141dee99624fa33b165df8c39f4c4de57c12b8f125a177bc9e4c76"
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
