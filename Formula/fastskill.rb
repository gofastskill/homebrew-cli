# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.194/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "b6dfa48b699dcbd784213c8a2feb5dc4221ea6d908163a4769c8ce86cc3e9386"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.194/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "b55dea8a4af1fd3e940b120062e92080eb377b03a9f2f0069e15f41a405b37c7"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.194/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "9581c4559dd5103e77296ce9c439b17e11f21be5b8fde3c7e91b2ec3802f0f45"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.194/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "463d8867da649253358a4be5bee89c104f21a031ba8baf69d6b17bffc6e797a6"
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
