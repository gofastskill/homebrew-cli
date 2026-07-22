# typed: false
# frozen_string_literal: true

class Fastskill < Formula
  desc "Skill package manager and operational toolkit"
  homepage "https://github.com/gofastskill/fastskill"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.151/fastskill-aarch64-apple-darwin.tar.gz"
      sha256 "4715983c63c39055a5587cb7bb1bd60426222f3693ecf110daa7ebcae794728b"
    end

    on_intel do
      url "https://github.com/gofastskill/fastskill/releases/download/v0.9.151/fastskill-x86_64-apple-darwin.tar.gz"
      sha256 "0d9b370b1ee0b24a27ae3b2059453207543a70d5b4a423d0d44460b2a31922a1"
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
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.151/fastskill-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "53652e5a8834cd6b44468158343cb6422a55fc6b9d43e52fdd9b266008c1ef7d"
      else
        url "https://github.com/gofastskill/fastskill/releases/download/v0.9.151/fastskill-x86_64-unknown-linux-musl.tar.gz"
        sha256 "d30962038be0556a620223c56d3363e4ed92e23ba6231d52a9868c14d5e12640"
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
