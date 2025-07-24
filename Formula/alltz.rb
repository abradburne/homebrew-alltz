class Alltz < Formula
  desc "🌍 Terminal-based timezone viewer for developers and remote teams"
  homepage "https://github.com/abradburne/alltz"
  version "0.1.4"
  license "MIT"

  # Primary installation method: precompiled binaries
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abradburne/alltz/releases/download/v0.1.4/alltz-aarch64-apple-darwin.tar.gz"
      sha256 "149eb1e17c583655c401d8e473cd0713e35f4a45a82aaab2198517a1e7a0cda8" # aarch64
    else
      url "https://github.com/abradburne/alltz/releases/download/v0.1.4/alltz-x86_64-apple-darwin.tar.gz"
      sha256 "4d0900c96884bab174035be5bdc11efecd80645676e2c422716fbe93ee718b71" # x86_64
    end
  end

  on_linux do
    url "https://github.com/abradburne/alltz/releases/download/v0.1.4/alltz-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "1d0b46f624fdc9acb88063db544f6363ea867c3836d3b5456473bc2f62997f44" # linux
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
    assert_match "alltz 0.1.4", shell_output("#{bin}/alltz --version")

    # Test CLI commands
    assert_match "Available Timezones", shell_output("#{bin}/alltz list")
    assert_match "Current time", shell_output("#{bin}/alltz time London")
  end
end