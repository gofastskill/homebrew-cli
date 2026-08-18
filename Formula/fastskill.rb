# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.176/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "006e41e8c4fbb2ed8c22a5771227659361968ee2243e5a4269c9a55647c0c913"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.176/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "badc15ac16cc20938489d8360674a011cafaff82fbe3f24540e4ba03fcdfd5b6"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.176/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "783ac7308377cad93ef054fcd03d25447a1ae8e8618f1967b808e7c317c82a04"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.176/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "d9aaa1cd17da2022c0132a1386f16386226d11f6adece0297455ab7f15dd3375"
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
