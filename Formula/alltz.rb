class Alltz < Formula
  desc "🌍 Terminal-based timezone viewer for developers and remote teams"
  homepage "https://github.com/abradburne/alltz"
  version "0.1.3"
  license "MIT"

  # Primary installation method: precompiled binaries
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abradburne/alltz/releases/download/v0.1.3/alltz-aarch64-apple-darwin.tar.gz"
      sha256 "776d69e48ea849aeb76ee73c69dbe588aa266eb6bae56de430d2ae8ddf2d555f" # aarch64
    else
      url "https://github.com/abradburne/alltz/releases/download/v0.1.3/alltz-x86_64-apple-darwin.tar.gz"
      sha256 "97c78c6564385b2f78d246da29b1105bbda36772704fbe37baf18005da7c037f" # x86_64
    end
  end

  on_linux do
    url "https://github.com/abradburne/alltz/releases/download/v0.1.3/alltz-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "54eac486ab6d82cecaab15cb055cd74faa8b374be1d7c7076ab1f86240f48805" # linux
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