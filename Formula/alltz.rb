class Alltz < Formula
  desc "🌍 Terminal-based timezone viewer for developers and remote teams"
  homepage "https://github.com/abradburne/alltz"
  version "0.1.0"
  license "MIT"

  # Primary installation method: precompiled binaries
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abradburne/alltz/releases/download/v0.1.0/alltz-aarch64-apple-darwin.tar.gz"
      sha256 "ceebee9b9b837b4348185cd431bed217f15c980c7b0d803459dab8b3b5aa52b0" # aarch64
    else
      url "https://github.com/abradburne/alltz/releases/download/v0.1.0/alltz-x86_64-apple-darwin.tar.gz"
      sha256 "2209bf4923f4b233fd8f5a7608b86087b467ad10ff7b7e0cd78eb28123c792e5" # x86_64
    end
  end

  on_linux do
    url "https://github.com/abradburne/alltz/releases/download/v0.1.0/alltz-x86_64-apple-darwin.tar.gz"
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