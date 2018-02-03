require "test_helper"

class Rm3u::SegmentTest < Minitest::Test
  def test_to_json
    segment = Rm3u::Segment.new(path: "Foobar", tags: [Rm3u::Tag.new(name: "Foobar")])
    tag = JSON.generate({ name: "Foobar", content: nil })
    json = JSON.generate({ path: "Foobar", tags: [tag] })
    assert_equal json, segment.to_json
  end
end
