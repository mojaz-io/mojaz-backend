require "rails_helper"

RSpec.describe Zoofs::ParserFinder do
  let(:parser_finder) { described_class.new }

  describe "#initialize" do
    it "initialize correctly" do
      expect(parser_finder.parsers.size).to be > 0
    end

    it "loads all the parsers" do
      count = Dir[Rails.root.join("app", "lib", "zoofs", "parsers", "**", "*.rb")].count
      expect(parser_finder.parsers.size).to eq count
    end
  end

  describe "#find_parser_for" do
    it "returns Zoofs::Parsers::NullParser for unmatched url" do
      bad_url = "www.google.com"
      expect(parser_finder.find_parser_for(url: bad_url)).to eq Zoofs::Parsers::NullParser
    end

    it "returns the correct parser for a matched url" do
      good_url = "http://www.bbc.co.uk/arabic/middleeast-49492076"
      expect(parser_finder.find_parser_for(url: good_url)).to eq Zoofs::Parsers::Bbc
    end
  end
end
