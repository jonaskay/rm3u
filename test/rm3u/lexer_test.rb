require "test_helper"

class Rm3u::LexerTest < Minitest::Test
  def setup
    @parser = Rm3u::Parser.new
  end 

  def test_for_blank
    result = @parser.tokenize("   \n")
    assert_equal [], result
  end 

  def test_for_extm3u
    result = @parser.tokenize("#EXTM3U\n")
    assert_equal [[:EXTM3U, "#EXTM3U"]], result
  end 

  def test_for_extinf
    ["#EXTINF\n", "#EXTINF&foobar\n"].each do |str|
      result = @parser.tokenize(str)
      assert_equal [[:EXTINF, "#EXTINF"]], result 
    end 
  end 

  def test_for_extinf_and_ext_text
    result = @parser.tokenize("#EXTINF:\n")
    assert_equal [[:EXTINF, "#EXTINF"], [:EXT_TEXT, ""]], result

    result = @parser.tokenize("#EXTINF:123, Sample artist - Sample title\n")
    assert_equal [[:EXTINF, "#EXTINF"], [:EXT_TEXT, "123, Sample artist - Sample title"]], result
  end 

  def test_for_ext
    result = @parser.tokenize("#EXT-X-ENDLIST\n")
    assert_equal [[:EXT, "#EXT-X-ENDLIST"]], result
  end

  def test_for_ext_and_ext_text 
    result = @parser.tokenize("#EXT-X-TARGETDURATION:\n")
    assert_equal [[:EXT, "#EXT-X-TARGETDURATION"], [:EXT_TEXT, ""]], result

    result = @parser.tokenize("#EXT-X-TARGETDURATION:10\n")
    assert_equal [[:EXT, "#EXT-X-TARGETDURATION"], [:EXT_TEXT, "10"]], result
  end 

  def test_for_rem
    result = @parser.tokenize("# Comment\n")
    assert_equal [[:REM, "# Comment"]], result
  end

  def test_for_path
    result = @parser.tokenize("C:\\Documents and Settings\\I\\My Music\\Sample.mp3\n")
    assert_equal [[:PATH, "C:\\Documents and Settings\\I\\My Music\\Sample.mp3"]], result
  end 
end
