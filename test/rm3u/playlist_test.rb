require "test_helper"

class Rm3u::PlaylistTest < Minitest::Test 
  def test_parse
    playlist = Rm3u::Playlist.parse("Foobar.mp3")
    assert_instance_of Rm3u::Playlist, playlist
  end 

  def test_parse_file
    playlist = Rm3u::Playlist.parse_file("test/fixtures/simple.m3u")
    assert_instance_of Rm3u::Playlist, playlist
  end
  
  def test_to_json
    playlist = Rm3u::Playlist.new(
      header: Rm3u::Tag.new(name: "Foobar"), 
      tags: [Rm3u::Tag.new(name: "Foobar", content: "Foobar")],
      segments: [Rm3u::Segment.new(path: "Foobar", tags: [Rm3u::Tag.new(name: "Foobar")])])
    header = JSON.generate({ name: "Foobar", content: nil })
    tag = JSON.generate({ name: "Foobar", content: "Foobar" })
    segment_tag = JSON.generate({ name: "Foobar", content: nil })
    segment = JSON.generate({ path: "Foobar", tags: [segment_tag] })
    json = JSON.generate(header: header, tags: [tag], segments: [segment])
    assert_equal json, playlist.to_json
  end
end
