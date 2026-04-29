cask "cadente" do
  version "0.2.38"

  if Hardware::CPU.arm?
    url "https://github.com/cadente-hub/cadente-hub.github.io/releases/download/v#{version}/cadente-#{version}-macos-arm64.dmg"
    sha256 "2b9d5365b1f2d30ddb2c53478ae029cb8925fbcef2dd66ae73cc1b7aa4e94ede"
  else
    url "https://github.com/cadente-hub/cadente-hub.github.io/releases/download/v#{version}/cadente-#{version}-macos-x64.dmg"
    sha256 "b32826d20c83d5bc46f2d0419e99e6082289fd88cc74de3fedc4d7b36e3796f2"
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

  # Strip macOS quarantine so the app opens without "is damaged" Gatekeeper error.
  # Required for unsigned apps — works on both Intel and Apple Silicon (incl. M4).
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/Cadente.app"],
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
