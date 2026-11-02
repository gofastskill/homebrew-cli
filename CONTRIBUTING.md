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

`Formula/fastskill.rb` is generated and committed automatically for each stable release of fastskill. Do not edit it by hand: the next release overwrites it. Changes to the formula's contents belong in the generator, so open an issue here if something in it is wrong.

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

