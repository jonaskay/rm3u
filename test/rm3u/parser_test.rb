require "test_helper"
require "json"

class Rm3u::ParserTest < Minitest::Test
  def setup
    @parser = Rm3u::Parser.new
  end

  def test_that_it_parses_a_blank_string
    result = @parser.scan_str("   ")
    assert_nil result
  end 

  def test_that_it_parses_a_playlist_string
    playlist = Rm3u::Playlist.parse("#EXTM3U\nSample.mp3\nGreatest Hits\\Example.ogg")
    json = JSON.generate({ 
      header: JSON.generate({ name: "#EXTM3U", content: nil }),
      tags: [],
      segments: [
        JSON.generate({ path: "Sample.mp3", tags: [] }), 
        JSON.generate({ path: "Greatest Hits\\Example.ogg", tags: [] })
      ]
    })
    assert_equal json, playlist.to_json
  end

  def test_that_it_parses_an_empty_file
    result = @parser.scan_file("test/fixtures/empty.m3u")
    assert_nil result 
  end

  def test_that_it_parses_a_playlist_file
    playlist = @parser.scan_file("test/fixtures/simple.m3u")
    json = JSON.generate({
      header: JSON.generate(nil),
      tags: [],
      segments: [
        JSON.generate({ 
          path: "C:\\Documents and Settings\\I\\My Music\\Sample.mp3",
          tags: []
        }),
        JSON.generate({
          path: "C:\\Documents and Settings\\I\\My Music\\Greatest Hits\\Example.ogg",
          tags: []
        })
      ]
    })
    assert_equal json, playlist.to_json
  end

  def test_should_scan_an_extended_playlist
    playlist = @parser.scan_file("test/fixtures/extended.m3u")
    json = JSON.generate({
      header: JSON.generate({ name: "#EXTM3U", content: nil }),
      tags: [],
      segments: [
        JSON.generate({
          path: "Sample.mp3",
          tags: [
            JSON.generate({ name: "#EXTINF", content: "123, Sample artist - Sample title" }),
          ]
        }),
        JSON.generate({
          path: "Greatest Hits\\Example.ogg",
          tags: [
            JSON.generate({ name: "#EXTINF", content: "321,Example Artist - Example title" }),
          ]
        })
      ]
    })
    assert_equal json, playlist.to_json
  end 

  def test_should_scan_an_hls_playlist
    playlist = @parser.scan_file("test/fixtures/hls.m3u")
    json = JSON.generate({
      header: JSON.generate({ name: "#EXTM3U", content: nil }),
      tags: [
        JSON.generate({ name: "#EXT-X-TARGETDURATION", content: "10" }),
        JSON.generate({ name: "#EXT-X-VERSION", content: "3" }),
        JSON.generate({ name: "#EXT-X-ENDLIST", content: nil })
      ],
      segments: [
        JSON.generate({
          path: "http://media.example.com/first.ts",
          tags: [
            JSON.generate({ name: "#EXTINF", content: "9.009," })
          ]
        }),
        JSON.generate({
          path: "http://media.example.com/second.ts",
          tags: [
            JSON.generate({ name: "#EXTINF", content: "9.009," })
          ]
        }),
        JSON.generate({
          path: "http://media.example.com/third.ts",
          tags: [
            JSON.generate({ name: "#EXTINF", content: "3.003," })
          ]
        })
      ]
    })
    assert_equal json, playlist.to_json
  end 
end
