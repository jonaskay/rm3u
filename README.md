# Rm3u

Rm3u is a simple parser for reading M3U playlist files.

## Installation

This gem is currently not available for installation via Rubygems.

## Usage (parsing)

Read a playlist from a string.

```ruby
playlist = Rm3u::Playlist.parse("#EXTM3U\n#EXTINF:123,Foobar - Foobar\nFoobar.mp3")
playlist
# => #<Rm3u::Playlist:0x00007fffbd14e820 @header=#<Rm3u::Tag:0x00007fffbd14e0a0 @name="#EXTM3U", @content=nil>, @tags=[], @segments=[#<Rm3u::Segment:0x00007fffbd14e348 @path="Foobar.mp3", @tags=[#<Rm3u::Tag:0x00007fffbd14e2a8 @name="#EXTINF", @content="123,Foobar - Foobar">]>]>
```

Read a playlist from a file.

```ruby
playlist = Rm3u::Playlist.parse_file("test/fixtures/simple.m3u")
playlist
```

## M3U format

There is no formal specification for the M3U format. Therefore, Rm3u does not follow any particular standard. The following is the specification used by Rm3u:

* Each line is either blank, pathname or starts with the '#' character.
* Comment and tag lines are prefaced by the '#' character. Tags begin with #EXT. Other lines beginning with # are comments which are ignored by the parser.
* #EXTM3U tags are header tags. If the header tag is present, it should be the first line of the file.
* #EXTINF tags provide further information for playlist items.

Rm3u::Playlist has a header, tags, and segments:

* Header refers to the #EXTM3U tag. It's an instance of the Rm3u::Tag class. You can access header with `playlist.header`.
* Tags is a collection of Rm3u::Tag instances that do not belong to any segment. You can access tags with `playlist.tags`.
* Segments represent playlist items (tracks, URIs, or other playlists). Segments is a collection of Rm3u::Segment instances. You can access segments with `playlist.segments`.

Rm3u::Tag has a name and content:

* Name is the name of the tag (e.g. "#EXTM3U", "EXTINF"). You can access name with `tag.name`.
* Content is the possible text content that follows the tag. You can access content with `tag.content`.

Rm3u::Segment has a path and tags:

* Path is the pathname of the segment. You can access path with `segment.path`.
* Tags is a collection of Rm3u::Tag instances associated to the segment. You can access tags with `segment.tags`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rm3u. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rm3u project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rm3u/blob/master/CODE_OF_CONDUCT.md).
