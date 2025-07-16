class Alltz < Formula
  desc "🌍 Terminal-based timezone viewer for developers and remote teams"
  homepage "https://github.com/abradburne/alltz"
  version "0.1.1"
  license "MIT"

  # Primary installation method: precompiled binaries
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abradburne/alltz/releases/download/v0.1.1/alltz-aarch64-apple-darwin.tar.gz"
      sha256 "36e1663fea97edd7024b232af510f14b57caaf9ff0bacbd37dd44ca165f8ad16" # aarch64
    else
      url "https://github.com/abradburne/alltz/releases/download/v0.1.1/alltz-x86_64-apple-darwin.tar.gz"
      sha256 "1bda098f0ff2137ecfb9e392f13d1f411621bfe3ccd76e6e0033d71caab8f4cf" # x86_64
    end
  end

  on_linux do
    url "https://github.com/abradburne/alltz/releases/download/v0.1.1/alltz-x86_64-apple-darwin.tar.gz"
    sha256 "PLACEHOLDER_LINUX_HASH" # linux
  end

  # Alternative: build from source (requires Rust toolchain)
  head do
    url "https://github.com/abradburne/alltz.git", branch: "main"
    depends_on "rust" => :build
  end

  def install
    if build.head?
      # Build from source
      system "cargo", "install", "--locked", "--root", prefix, "--path", "."
    else
      # Install precompiled binary
      bin.install "alltz"
    end
  end

  test do
    assert_match "alltz 0.1.0", shell_output("#{bin}/alltz --version")

    # Test CLI commands
    assert_match "Available Timezones", shell_output("#{bin}/alltz list")
    assert_match "Current time", shell_output("#{bin}/alltz time London")
  end
end