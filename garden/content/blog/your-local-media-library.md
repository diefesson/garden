+++
title = "Your Local Media Library"
description = "A list of free and open source software for enjoying and managing a local media library."
authors = ["Diefesson"]
date = 2026-06-22
updated = 2026-06-26
+++

## [VLC](https://www.videolan.org)

VLC Media Player, previously know as VideoLAN Client, is a versatile media player powered by FFmpeg. It can play a wide range of video and audio formats, also supporting subtitles, playlists, network media streams and discovery of network media servers (including UPnP/DLNA). The VLsub extension can be used to fetch movie and series subtitles. I have personally used it on Linux, Windows and Android, and so far it was capable of opening anything I throw at it.

## [Tauon](https://tauonmusicbox.rocks)

Tauon is a playlist oriented music player with fast indexing. It features normal/synced lyrics, integration with scrobblers (eg: last.fm), streaming (eg: Jellyfin, other Tauon instances), network radios, generated playlists, and a widget-like player.

It's UI layout is truly something else. Different from most alternatives it hasn't a central UI showing all musics, but a similar experience can be achieved by simply dragging your folders to the default playlist and managing from there. While the queue provides a way to control the flow by jumping to specific entries, even between playlists.

## [MusicBrainz Picard](https://picard.musicbrainz.org)

A music tagger powered by [MusicBrainz](https://musicbrainz.org) and [AcousticID](https://acoustid.org) databases. It can identify a music by acousticID and tags. Features include tag completion, file renaming, and fetching album cover. Additionally you can use Lrclib Lyrics plugin to fetch lyrics from [LRCLIB](https://lrclib.net) during music identification.

## [FFmpeg](https://ffmpeg.org)

FFmpeg is a collection of libraries and CLI tools to manipulate, inspect and play media with support for a wide variety of formats. It's commands are the following:

- `ffmpeg`: Apply media manipulation such as transcoding and remuxing; combining and splitting streams; and applying effects. For advanced use cases it offers a graph like language to define complex pipelines. It also accepts input/output from default streams.
- `ffprobe`: Shows media metadata, such as container, streams, codecs, and so on.
- `ffplay`: A barebones media player without UI. It's very useful for peeking at a file content.

Example of converting an audio file:

```bash
ffmpeg -i music.flac -b:a 192 music.mp3
```

## [ExifTool](https://exiftool.org)

A CLI tool for visualizing and editing file metadata with support for a lot of formats.

Usage examples:

```bash
# Listing a music metadata
exiftool music.opus

# Group listed metadata
exiftool -g music.opus

# Extracting a specific metadata
exiftool -title music.opus

# Extracting from a specific group
exiftool -opus:title music.opus

# Extracting binary data
exiftool -b -picture music.opus > picture.jpg

# Changing file name based on metadata
exiftool '-filename<%artist - $title.%le' music.opus
```
