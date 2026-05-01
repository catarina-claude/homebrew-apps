cask "cadente" do
  version "0.2.43"

  if Hardware::CPU.arm?
    url "https://github.com/cadente-hub/cadente-hub.github.io/releases/download/v#{version}/cadente-#{version}-macos-arm64.dmg"
    sha256 "a8cc4bd5ac8e9940310e2a23e2ae149025416d4510ebeb72ef70fdc61bc3fb83"
  else
    url "https://github.com/cadente-hub/cadente-hub.github.io/releases/download/v#{version}/cadente-#{version}-macos-x64.dmg"
    sha256 "7ed84f489805d1d23e4c428084b6cfbe90779696dc869af09b7e4ec98bd2473a"
  end

  name "Cadente"
  desc "AI-powered desktop assistant — chat, terminal, Git, API testing, and more"
  homepage "https://cadente-hub.github.io"

  livecheck do
    url "https://github.com/cadente-hub/cadente-hub.github.io/releases/latest"
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: ">= :catalina"

  app "Cadente.app"

  # Strip macOS quarantine + re-sign ad-hoc locally so the app opens without
  # "is damaged" Gatekeeper error. Required for unsigned apps — robust on both
  # Intel and Apple Silicon (M1–M4) regardless of original signature state.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/Cadente.app"],
                   sudo: true
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/Cadente.app"],
                   sudo: true
    system_command "/usr/bin/open",
                   args: ["#{appdir}/Cadente.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/com.cadente.app",
    "~/Library/Caches/com.cadente.app",
    "~/Library/Preferences/com.cadente.app.plist",
    "~/Library/Saved Application State/com.cadente.app.savedState",
  ]
end
