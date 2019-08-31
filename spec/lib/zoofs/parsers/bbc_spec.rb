require "rails_helper"

RSpec.describe Zoofs::Parsers::Bbc do
  describe "#parse" do
    context "when news article" do
      it "extracts the data correctly", :vcr do
        VCR.use_cassette("bbc_article") do
          url = "http://www.bbc.co.uk/arabic/middleeast-49492076"
          parser = described_class.new url
          parser.parse
          expect(parser.content_response.keys).to eq %w[css]
          expect(parser.content_response["css"].size).to eq 60
        end
      end
    end

    context "when media article" do
      it "extracts the data correctly", :vcr do
        VCR.use_cassette("bbc_media") do
          url = "http://www.bbc.co.uk/arabic/media-49474522"
          parser = described_class.new url
          parser.parse
          expect(parser.content_response.keys).to eq %w[css]
          expect(parser.content_response["css"].size).to eq 2
        end
      end

      xit "extracts video embed correctly", :vcr do
        VCR.use_cassette("bbc_video") do
          url = "http://www.bbc.com/arabic/media-49474522"
          bbc = described_class.new url
          response = bbc.parse
          puts response.video_src
        end
      end
    end
  end
end
