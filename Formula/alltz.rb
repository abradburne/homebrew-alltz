class Alltz < Formula
  desc "🌍 Terminal-based timezone viewer for developers and remote teams"
  homepage "https://github.com/abradburne/alltz"
  version "0.1.2"
  license "MIT"

  # Primary installation method: precompiled binaries
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abradburne/alltz/releases/download/v0.1.2/alltz-aarch64-apple-darwin.tar.gz"
      sha256 "4e4c41e433450553a1017de5b31af9ff7e41ff68c60046bfbef63dd2f14b0bf3" # aarch64
    else
      url "https://github.com/abradburne/alltz/releases/download/v0.1.2/alltz-x86_64-apple-darwin.tar.gz"
      sha256 "9b94d643d0f0ee3a056250aca9a1394b44a26dbbd32ee164476f3658169737ea" # x86_64
    end
  end

  on_linux do
    url "https://github.com/abradburne/alltz/releases/download/v0.1.2/alltz-x86_64-apple-darwin.tar.gz"
    sha256 "e8ac8adffdd2e07e722a88f8d1a3b8ff082b76894a877d83783a6fb254e1343b" # linux
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