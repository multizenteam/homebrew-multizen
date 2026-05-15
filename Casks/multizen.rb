cask "multizen" do
  arch arm: "arm64", intel: "x64"

  version "0.2.4"
  sha256 arm:   "e8d6d9c6a8e35a1a767cc0b74e12722eac24466c0747ba31db24502dadf2bd8f",
         intel: "0726bd82348abeb32da1f3a05808cb3a824760ebe73d8e74a6bab9c662091a67"

  url "https://github.com/multizenteam/multizen-browser/releases/download/v#{version}/MultiZen-mac-#{arch}.dmg",
      verified: "github.com/multizenteam/multizen-browser/"
  name "MultiZen"
  desc "Browser library for AI agents and human operators, MCP-native, anti-detect"
  homepage "https://getmultizen.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates false
  # Electron 33 supports macOS 11 Big Sur and up. Match the binary's
  # actual minimum so audit's "artifact :big_sur vs cask :sonoma"
  # warning doesn't fire.
  depends_on macos: ">= :big_sur"

  app "MultiZen.app"

  # MultiZen is ad-hoc signed but not Apple-notarized (no Developer
  # ID yet). Brew applies its own quarantine attribute by default,
  # which makes Sequoia show the "is damaged" Gatekeeper dialog even
  # on cask-installed apps. Strip the quarantine flag after install
  # so users can launch the app from Finder without friction.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-d", "com.apple.quarantine", "#{appdir}/MultiZen.app"],
                   must_succeed: false
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/MultiZen.app"],
                   must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/MultiZen",
    "~/Library/Caches/com.multizen.desktop",
    "~/Library/Preferences/com.multizen.desktop.plist",
    "~/Library/Saved Application State/com.multizen.desktop.savedState",
  ]
end
