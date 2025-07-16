# Homebrew Tap for alltz

🌍 Terminal-based timezone viewer for developers and remote teams

## Installation

```bash
brew tap abradburne/alltz
brew install alltz
```

## About alltz

alltz provides visual timeline scrubbing across multiple timezones with DST indicators, color themes, and persistent configuration. Built with Rust for fast CLI workflow integration.

**Features:**
- Multi-timezone display with UTC offset ordering
- Timeline scrubbing with visual indicators  
- 6 color themes (Default, Ocean, Forest, Sunset, Cyberpunk, Monochrome)
- DST indicators (⇈ spring forward, ⇊ fall back)
- Persistent configuration
- CLI commands (list, time <city>, zone <city>)

## Usage

```bash
# Launch interactive TUI
alltz

# List available timezones
alltz list

# Get current time for a city
alltz time Tokyo

# Get timezone info
alltz zone London
```

## Repository

- **Main project**: https://github.com/abradburne/alltz
- **Documentation**: See main repository README
- **Issues**: Report issues in the main repository