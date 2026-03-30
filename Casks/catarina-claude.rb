cask "catarina-claude" do
  version "0.2.0"

  if Hardware::CPU.arm?
    url "https://github.com/catarina-claude/catarina-claude.github.io/releases/download/v#{version}/catarina-claude-#{version}-macos-arm64.dmg"
    sha256 "718b2ce710f8be959f790bda02e38e87f59c9f7cadfe7da51125cab656cf24c5"
  else
    url "https://github.com/catarina-claude/catarina-claude.github.io/releases/download/v#{version}/catarina-claude-#{version}-macos-x64.dmg"
    sha256 "f3167b0c87fc4f81154df6567ff3bd465b1c9542e2089536aaf15472b4eb8a9a"
  end

  name "Catarina Claude"
  desc "AI-powered desktop assistant — chat, terminal, Git, API testing, and more"
  homepage "https://catarina-claude.github.io"

  livecheck do
    url "https://github.com/catarina-claude/catarina-claude.github.io/releases/latest"
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: ">= :catalina"

  app "Catarina Claude.app"

  zap trash: [
    "~/Library/Application Support/com.catarina-claude.app",
    "~/Library/Caches/com.catarina-claude.app",
    "~/Library/Preferences/com.catarina-claude.app.plist",
    "~/Library/Saved Application State/com.catarina-claude.app.savedState",
  ]
end
