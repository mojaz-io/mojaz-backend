require "rails_helper"

RSpec.describe Zoofs::Parsers::TheVerge do
  describe "#parse" do
    it "extracts the data correctly", :vcr do
      VCR.use_cassette("the_verge_article") do
        url = "https://www.theverge.com/good-deals/2019/8/29/20838448/sandisk-512gb-microsd-card-storage-nintendo-switch-lite-deal-sale-discount"
        parser = described_class.new url
        parser.parse
        expect(parser.content_response.keys).to eq %w[css]
        expect(parser.content_response["css"].size).to eq 3
        expect(parser.image_response["css"].size).to eq 1
      end
    end
  end
end
