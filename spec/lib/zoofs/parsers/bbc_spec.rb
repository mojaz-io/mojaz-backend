require "rails_helper"

RSpec.describe Zoofs::Parsers::Bbc do
  describe "#parse" do
    context "when news article" do
      it "extracts the data correctly", :vcr do
        VCR.use_cassette("bbc_article") do
          url = "http://www.bbc.co.uk/arabic/middleeast-49492076"
          bbc = described_class.new url
          response = bbc.parse
          expect(response.formulas_response.keys).to eq %w[css]
          expect(response.formulas_response["css"].size).to eq 60
        end
      end
    end

    context "when media article" do
      it "extracts the data correctly", :vcr do
        VCR.use_cassette("bbc_media") do
          url = "http://www.bbc.co.uk/arabic/media-49474522"
          bbc = described_class.new url
          response = bbc.parse
          expect(response.formulas_response.keys).to eq %w[css]
          expect(response.formulas_response["css"].size).to eq 2
        end
      end
    end
  end
end
