# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://gofastskill.com"
  version "0.9.280"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.gofastskill.com/fastskill/v/0.9.280/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "267b1cddcb1c2634638afdd81420625d685c77dc9bb63cd0a7f17e44c1a5603d"
    end

    on_intel do
      url "https://get.gofastskill.com/fastskill/v/0.9.280/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "8dd2f217cd8caa906c3d9d4d9fb777ca854cc9adf356549a68914893f2c5dbf6"
    end
  end

  on_linux do
    on_arm do
      url "https://get.gofastskill.com/fastskill/v/0.9.280/fastskill-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a3a7dc19614a8066149db00473db259b6a2994c7f02457bc974cfd42fc7c4711"
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
        url "https://get.gofastskill.com/fastskill/v/0.9.280/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "81e9d5f68b51e97a0eb36d9ced2d366ad2f06b0c030a86a65a0fdc61ac61bd0b"
      else
        url "https://get.gofastskill.com/fastskill/v/0.9.280/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "01709cb8106fa3ca841e7ef5ec1f7a07a18d5efd1268c8801cc27b3fea43f7b8"
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
