cask "multizen" do
  arch arm: "arm64", intel: "x64"

  version "0.2.10"
  sha256 arm:   "2e714884d8f5bc02385ffeaa78f018a107def27f4d2c672f1a58fba82ad3435d",
         intel: "7ff0dd496ce5e3e5f235e72312ef00c815436785b1f4ac976e4c2e28512529bb"

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
