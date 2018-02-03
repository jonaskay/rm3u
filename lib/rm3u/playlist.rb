module Rm3u
  class Playlist
    attr_accessor :header, :tags, :segments

    def initialize(options={})
      @header = options[:header]
      @tags = options[:tags] || []
      @segments = options[:segments] || []
    end

    def self.parse(str)
      parser = Parser.new
      parser.scan_str(str)
    end

    def self.parse_file(file)
      parser = Parser.new 
      parser.scan_file(file)
    end

    def to_json
      hash = { 
        header: @header.to_json,
        tags: @tags.map(&:to_json), 
        segments: @segments.map(&:to_json)
      }
      hash.to_json
    end
  end
end
