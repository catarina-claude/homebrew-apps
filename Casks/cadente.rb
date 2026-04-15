cask "cadente" do
  version "0.2.15"

  if Hardware::CPU.arm?
    url "https://github.com/cadente-hub/cadente-hub.github.io/releases/download/v#{version}/cadente-#{version}-macos-arm64.dmg"
    sha256 "89c8b10d2e527b5c9f7380504f6915b497db26b61aaa2616119b8c4802572aa1"
  else
    url "https://github.com/cadente-hub/cadente-hub.github.io/releases/download/v#{version}/cadente-#{version}-macos-x64.dmg"
    sha256 "aed2bd783b93ef1c034cbe23fcb9871406671d50b191a356a482c120b7817c77"
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

  zap trash: [
    "~/Library/Application Support/com.cadente.app",
    "~/Library/Caches/com.cadente.app",
    "~/Library/Preferences/com.cadente.app.plist",
    "~/Library/Saved Application State/com.cadente.app.savedState",
  ]
end
