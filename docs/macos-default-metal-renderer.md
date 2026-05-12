# macOS default Metal renderer

This branch makes macOS app launches inherit:

```text
VT_FORCE_METAL=1
```

Moonlight already supports this environment variable in `app/streaming/video/ffmpeg-renderers/vt_metal.mm`. Adding it to `app/Info.plist` makes Finder/Launchpad/Spotlight launches prefer the Metal renderer without wrapping the executable from a shell.

This was verified to avoid the slower-feeling `AVSampleBufferDisplayLayer` presentation path on an iMac18,3 Radeon Pro 580 client when streaming real `5120x2880` content.
