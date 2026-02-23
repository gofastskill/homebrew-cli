# Homebrew Tap for Fastskill

Install [fastskill](https://github.com/gofastskill/fastskill) via Homebrew on macOS and Linux.

## Installation

```bash
brew install gofastskill/cli/fastskill
```

## Platform Notes

- macOS Apple Silicon uses `fastskill-aarch64-apple-darwin.tar.gz`
- macOS Intel uses `fastskill-x86_64-apple-darwin.tar.gz`
- Linux uses dynamic selection between `linux-gnu` and `linux-musl` archives

## Usage

```bash
fastskill --version
```

For detailed usage and documentation, please refer to:
- GitHub: https://github.com/gofastskill
- Documentation: https://docs.gofastskill.com/

## Upgrading

```bash
brew upgrade fastskill
```

## Uninstalling

```bash
brew uninstall fastskill
brew untap gofastskill/cli
```
