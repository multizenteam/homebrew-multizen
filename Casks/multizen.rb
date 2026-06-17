cask "multizen" do
  arch arm: "arm64", intel: "x64"

  version "0.2.8"
  sha256 arm:   "4e16e4b71215193dc659a37cc2f8347e0b4e002d9f86f8921bf43d08312852c5",
         intel: "f547a7da1e120c8fb5e158c6b6db05119925bde6b74e011805347b3d527d2bd0"

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
