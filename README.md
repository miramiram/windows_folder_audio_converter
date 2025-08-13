# windows_folder_audio_converter

## About
This PowerShell script safely converts a folder of audio files from flac to mp3, or any other format you give it with the `-from` and `-to` args.
The script is set to convert the output to 320Kbps, preserving the high quality audio.

The script opens a explorer window where you can pick a folder with audio files you want converted, then gives you a preview of the file conversions it'll make in a new folder, asking for confirmation before completing the conversion. 


## Requirements
You'll need `ffmpeg` installed and reachable on your path: https://ffmpeg.org/

## Shortcut
If you want to create a shortcut for this, right click an empty spot in windows explorer or your desktop to create a shortcut, use something like following in the "target" field of the shortcut:

`"C:\Program Files\PowerShell\7\pwsh.exe" -Command ".\folder_audio_filetype_converter.ps1 -from flac -to mp3"`

If you don't have Powershell 7 installed, the whole first section can be replaced with  `powershell.exe`.
