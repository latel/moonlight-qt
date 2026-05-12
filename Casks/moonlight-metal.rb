cask "moonlight-metal" do
  version "6.1.0-metal.1"
  sha256 "d494740eead8ad4e620cdc8feedb56083bc29cabbbeef34cb82585fd87725fa2"

  url "https://github.com/moonlight-stream/moonlight-qt/releases/download/v6.1.0/Moonlight-6.1.0.dmg"
  name "Moonlight Metal"
  desc "Moonlight with VT_FORCE_METAL enabled by default on macOS"
  homepage "https://github.com/latel/moonlight-qt"

  depends_on macos: ">= :big_sur"

  app "Moonlight.app"

  postflight do
    app_path = "#{appdir}/Moonlight.app"
    plist = "#{app_path}/Contents/Info.plist"

    system_command "/bin/sh", args: ["-c", <<~EOS]
      set -e
      /usr/libexec/PlistBuddy -c 'Delete :LSEnvironment' "#{plist}" >/dev/null 2>&1 || true
      /usr/libexec/PlistBuddy -c 'Add :LSEnvironment dict' "#{plist}"
      /usr/libexec/PlistBuddy -c 'Add :LSEnvironment:VT_FORCE_METAL string 1' "#{plist}"
      /usr/bin/xattr -dr com.apple.quarantine "#{app_path}" >/dev/null 2>&1 || true
      /usr/bin/codesign -s - --force --deep "#{app_path}"
    EOS
  end

  caveats <<~EOS
    Verify Metal renderer is enabled:
      /usr/libexec/PlistBuddy -c 'Print :LSEnvironment:VT_FORCE_METAL' /Applications/Moonlight.app/Contents/Info.plist

    Start Moonlight:
      open /Applications/Moonlight.app
  EOS
end
