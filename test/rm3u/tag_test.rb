require "test_helper"

class Rm3u::TagTest < Minitest::Test
  def test_to_json
    tag = Rm3u::Tag.new(name: "Foobar", content: "Foobar")
    json = JSON.generate({ name: "Foobar", content: "Foobar" })
    assert_equal json, tag.to_json
  end
end
