class Alltz < Formula
  desc "🌍 Terminal-based timezone viewer for developers and remote teams"
  homepage "https://github.com/abradburne/alltz"
  version "0.1.3"
  license "MIT"

  # Primary installation method: precompiled binaries
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abradburne/alltz/releases/download/v0.1.3/alltz-aarch64-apple-darwin.tar.gz"
      sha256 "5945d14a3872041dda2671a4a0231f48cd37900cb9ddff6c22074a233ae1e57d" # aarch64
    else
      url "https://github.com/abradburne/alltz/releases/download/v0.1.3/alltz-x86_64-apple-darwin.tar.gz"
      sha256 "b33af553c787537180600f308db2e1b0dfdbd55e76886dba4be4f01008400785" # x86_64
    end
  end

  on_linux do
    url "https://github.com/abradburne/alltz/releases/download/v0.1.3/alltz-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "732860061cf98221aa1d96c9c944650e21eb486950a519a81c55f1a6362f1665" # linux
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
    assert_match "alltz 0.1.2", shell_output("#{bin}/alltz --version")

    # Test CLI commands
    assert_match "Available Timezones", shell_output("#{bin}/alltz list")
    assert_match "Current time", shell_output("#{bin}/alltz time London")
  end
end