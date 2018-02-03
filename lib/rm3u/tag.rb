module Rm3u
  class Tag
    attr_accessor :name, :content

    def initialize(options={})
      @name = options[:name]
      @content = options[:content]
    end

    def to_json
      { name: @name, content: @content }.to_json
    end
  end
end
