cask "multizen" do
  arch arm: "arm64", intel: "x64"

  version "0.2.3"
  sha256 arm:   "e2f1619db2e76ec399bc39bf8fe84e450d00ae505e9351b66a6dff8f9b925940",
         intel: "f437ded4b65d0b727f48a953d054b8908694dc172d47ee7374f805c53898cb87"

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

  # Brew already strips the quarantine attribute on install, so users
  # do not need to run `xattr -cr` manually. The same Gatekeeper
  # "damaged" dialog that direct DMG downloads hit does not appear
  # for cask installs — Homebrew is treated as a trusted source
  # because the cask explicitly bypasses the quarantine bit.

  zap trash: [
    "~/Library/Application Support/MultiZen",
    "~/Library/Caches/com.multizen.desktop",
    "~/Library/Preferences/com.multizen.desktop.plist",
    "~/Library/Saved Application State/com.multizen.desktop.savedState",
  ]
end
