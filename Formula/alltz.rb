class Alltz < Formula
  desc "🌍 Terminal-based timezone viewer for developers and remote teams"
  homepage "https://github.com/abradburne/alltz"
  version "0.1.3"
  license "MIT"

  # Primary installation method: precompiled binaries
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abradburne/alltz/releases/download/v0.1.3/alltz-aarch64-apple-darwin.tar.gz"
      sha256 "7233ee6665b75c167b0d39c6641383cbe9bbb5568272d4160023b665a94b69ec" # aarch64
    else
      url "https://github.com/abradburne/alltz/releases/download/v0.1.3/alltz-x86_64-apple-darwin.tar.gz"
      sha256 "e39314bcc757b66efbcc4ab38feea9faa01d605dafe22f5ef507cd6d5508a80a" # x86_64
    end
  end

  on_linux do
    url "https://github.com/abradburne/alltz/releases/download/v0.1.3/alltz-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "a4e144a403f0cac9058f6fde5a1eda929d5efda0446a1707a53142f0c812da28" # linux
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