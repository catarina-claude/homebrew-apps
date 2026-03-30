cask "catarina-claude" do
  version "0.2.1"

  if Hardware::CPU.arm?
    url "https://github.com/catarina-claude/catarina-claude.github.io/releases/download/v#{version}/catarina-claude-#{version}-macos-arm64.dmg"
    sha256 "98d22d6d66b2b9c3d9a2629a84ac42ad8c76df01913c6e0de418ba79333dbdd3"
  else
    url "https://github.com/catarina-claude/catarina-claude.github.io/releases/download/v#{version}/catarina-claude-#{version}-macos-x64.dmg"
    sha256 "2d66ea44c87633b55a1f16e16468df487b83976c4d55c5397ee792763cd1e6a5"
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
