cask "moonlight-metal-local" do
  version "6.1.0-metal.local"
  sha256 "2afd18a364fc2c2da4d62d410e34a73a800fe2e4746b4052ee7daf24c80d8581"

  url "file:///tmp/moonlight-metal-offline/Moonlight-Metal-imac18_3.zip"
  name "Moonlight Metal Local"
  desc "Offline Moonlight build with VT_FORCE_METAL enabled"
  homepage "https://github.com/latel/moonlight-qt"

  depends_on macos: ">= :big_sur"

  app "Moonlight.app"

  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Moonlight.app"]
  end

  caveats <<~EOS
    Verify Metal renderer is enabled:
      /usr/libexec/PlistBuddy -c 'Print :LSEnvironment:VT_FORCE_METAL' /Applications/Moonlight.app/Contents/Info.plist

    Start Moonlight:
      open /Applications/Moonlight.app
  EOS
end
