# brute-force-video-settings

A bunch of wrappers around `ffmpeg` in order to facilitate brute forcing the
video settings (video codec, format and resolution) for the old car multimedia
system with Windows Embedded CE 6.0.

## Attempts

| Cmd   | Outcome |
| :---- | :------ |
| `ffmpeg -i input.mp4 -vf "scale=-2:480" output.avi` | only sound |
| `ffmpeg -i input.mp4 -vf "scale=-2:480" output.wmv` | skipped    |
| `ffmpeg -i input.mp4 -vf "scale=640:480" -c:v mpeg4 -vtag xvid -r 25 output.avi` | ? |
