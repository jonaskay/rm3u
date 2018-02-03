module Rm3u
  class Segment
    attr_accessor :path, :tags

    def initialize(options={})
      @path = options[:path]
      @tags = options[:tags] || []
    end

    def to_json
      { path: @path, tags: @tags.map(&:to_json) }.to_json
    end
  end
end
