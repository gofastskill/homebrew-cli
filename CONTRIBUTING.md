# Contributing to Homebrew Fastskill

## Repository Structure

```
homebrew-cli/
├── Formula/
│   └── fastskill.rb    # Homebrew formula
├── CONTRIBUTING.md     # This file
└── README.md           # End-user documentation
```

## Updating the Formula

When a new version of fastskill is released:

1. Update the `version` in `Formula/fastskill.rb`
2. Update the `url` to point to the new release
3. Calculate the new SHA256 checksum:
   ```bash
   curl -sL https://github.com/gofastskill/fastskill/releases/download/vX.Y.Z/fastskill-x86_64-unknown-linux-gnu.tar.gz | shasum -a 256
   ```
4. Update the `sha256` value in the formula
5. Test the installation locally:
   ```bash
   brew install --build-from-source Formula/fastskill.rb
   ```
6. Verify it works:
   ```bash
   fastskill --version
   ```

## Testing

Before submitting changes, test the formula locally:

```bash
# Install from local formula
brew install --build-from-source Formula/fastskill.rb

# Run the built-in test
brew test fastskill

# Uninstall when done testing
brew uninstall fastskill
```

## Submitting Changes

1. Fork this repository
2. Create a feature branch
3. Make your changes
4. Test locally
5. Submit a pull request

