# homebrew-multizen

Homebrew tap for [MultiZen](https://getmultizen.com), the open-source MCP browser for AI agents and human operators.

## Install

```
brew tap multizenteam/multizen
brew install --cask multizen
```

After the first install, future updates land via `brew upgrade --cask multizen`.

## Why a tap and not homebrew-cask main?

Submitting to the official `homebrew/cask` repo requires the app to be code-signed and notarized by Apple. MultiZen is not yet (we are working on it), so this private tap is the right place for now. The cask formula here is identical in structure to anything in `homebrew/cask` — same install UX, same auto-update flow.

When MultiZen gets Apple notarization we'll submit the cask upstream.

## Manual download

If you do not want Homebrew, download the DMG straight from the [releases page](https://github.com/multizenteam/multizen-browser/releases/latest). You'll need to strip the Gatekeeper quarantine flag once after install:

```
xattr -cr /Applications/MultiZen.app
```

## Source

The MultiZen app source lives in [multizenteam/multizen-browser](https://github.com/multizenteam/multizen-browser). This tap is just the Homebrew distribution shim.
