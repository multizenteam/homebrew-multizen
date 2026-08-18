cask "multizen" do
  arch arm: "arm64", intel: "x64"

  version "0.3.1"
  sha256 arm:   "1c5d8800f8b3c1864909f90a5cd179040f6043533119b015a012dc3dc4e0661e",
         intel: "6c3897e28c629b93aa4df06f7e315495dbd615e0dacef591f3c34db77cd33052"

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
