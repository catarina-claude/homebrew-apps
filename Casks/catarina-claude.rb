cask "catarina-claude" do
  version "0.1.4"

  if Hardware::CPU.arm?
    url "https://github.com/catarina-claude/catarina-claude.github.io/releases/download/v#{version}/catarina-claude-#{version}-macos-arm64.dmg"
    sha256 "a47abe5e40702e7cfe9536c65bbc3b6a3bbfedfbc832adca0a2b410336506112"
  else
    url "https://github.com/catarina-claude/catarina-claude.github.io/releases/download/v#{version}/catarina-claude-#{version}-macos-x64.dmg"
    sha256 "00c09e93e9021bbc7bd8695cc86854c053a369a5b4a25184d9cef638be16b32b"
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

  # Remove macOS quarantine flag so the app opens without Gatekeeper warnings
  # (required for apps not signed with an Apple Developer certificate)
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/Catarina Claude.app"],
                   sudo: false
    system_command "/usr/bin/open",
                   args: ["#{appdir}/Catarina Claude.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/com.catarina-claude.app",
    "~/Library/Caches/com.catarina-claude.app",
    "~/Library/Preferences/com.catarina-claude.app.plist",
    "~/Library/Saved Application State/com.catarina-claude.app.savedState",
  ]
end
