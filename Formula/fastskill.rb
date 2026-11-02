# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://gofastskill.com"
  version "0.9.279"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.gofastskill.com/v/0.9.279/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "31ba088e580944333d6b0e98345d6376b2b514a0066fa5a922eb1076a027c7c4"
    end

    on_intel do
      url "https://get.gofastskill.com/v/0.9.279/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "61ea0a1e9495edd9fe2d6fa1fb51166c22fa45554cc49631b72e117b54cf6f20"
    end
  end

  on_linux do
    on_arm do
      url "https://get.gofastskill.com/v/0.9.279/fastskill-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ecb9b92d97241f0e627a83aa9ddd18f05593deab64dfc9ba15058c7a1bb645b2"
    end

    on_intel do
      # glibc 2.38 or newer takes the glibc build; older or none (musl, as on
      # Alpine) takes the static one.
      glibc_version = begin
        `ldd --version 2>&1`.lines.first.to_s[/(\d+\.\d+)/].to_f
      rescue
        0
      end

      if glibc_version >= 2.38
        url "https://get.gofastskill.com/v/0.9.279/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "33b687e9aaf4d6a5f0f3ef7c319045e2c3e7e47b26ae42e4895bbdea5ec971bc"
      else
        url "https://get.gofastskill.com/v/0.9.279/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "4dfd6738e27a701537362f702bfbe72383cb2ab79b44b62a364ded8f8695dadd"
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
