# brute-force-video-settings

A bunch of wrappers around `ffmpeg` in order to facilitate brute forcing the
video settings (video codec, format and resolution) for the old car multimedia
system with Windows Embedded CE 6.0 (`DVM-3004` / `DVM-3004G`).

## DVM-3004G? info

### System parameters

#### Video systems:

AUTO PAL / NTSC / SECAM

#### Display resolution:

800 x 480 pixels

### DVD parameters

### Supported disks:

DVD / VCD / CD / MP3/ WMA / JPEG / MPEG4

## Encoding attempts

| Cmd   | Successful | Outcome |
| :---- | :--------: | :------ |
| `ffmpeg -i input.mp4 -vf "scale=-2:480" output.avi` | &#x274C; | only sound |
| `ffmpeg -i input.mp4 -vf "scale=-2:480" output.wmv` | &#x274C; | corrupted    |
| `ffmpeg -i input.mp4 -vf "scale=640:480" -c:v mpeg4 -vtag xvid -r 25 -qscale:v 5 -qscale:a 5 output.avi` | &#x2705; | flawless |
