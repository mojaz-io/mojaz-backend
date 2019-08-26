# frozen_string_literal: true

# Load All parsers from folder
Dir["parsers/*.rb"].each { |file| load file }

module Zoofs
  class ParserFinder
    attr_reader :parsers

    def initialize
      @parsers = Zoofs::Parsers.constants.map(&Parsers.method(:const_get)).grep(Class)
    end

    def find_parser_for(url:)
      @parsers.detect(proc { Zoofs::Parsers::NullParser }) { |parser| parser.can_parse?(url) }
    end
  end
end
