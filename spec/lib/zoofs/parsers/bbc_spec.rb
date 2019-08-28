require "rails_helper"

RSpec.describe Zoofs::Parsers::Bbc do
  describe "#parse" do
    context "when news article" do
      it "extracts the data correctly", :vcr do
        VCR.use_cassette("bbc_article") do
          url = "http://www.bbc.co.uk/arabic/middleeast-49492076"
          bbc = described_class.new url
          response = bbc.parse
          #puts response.body
        end
      end
    end
  end
end