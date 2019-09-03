require "rails_helper"

vcr_option = {
  cassette_name: "rss_feeds",
  allow_playback_repeats: "true"
}

RSpec.describe FeedReader, vcr: vcr_option do
  let(:link) { "https://daringfireball.net/feeds/json" }
  let(:service) { described_class.new(link) }

  describe "#valid_feed_url?" do
    it "returns true on valid feed url" do
      expect(service.valid_feed_url?).to be true
    end

    it "returns false on invalid feed url" do
      bad_link = "www.google.com"
      expect(described_class.new(bad_link).valid_feed_url?).to be false
    end
  end

  context "when feed doesn't exists" do
    it "creates a feed when no feed" do
      expect do
        service.create_feed!
      end.to change(Feed, :count).by(1)
    end
  end

  context "when feed exists" do
    before do
      service.create_feed!
    end

    it "doesn't create a duplicate feed on redirection", :vrc do
      VCR.use_cassette("rss_feeds_redirection") do
        expect do
          described_class.new("http://daringfireball.net/feeds/json").create_feed!
        end.to change(Feed, :count).by(0)
      end
    end

    it "doesn't create a duplicate feed" do
      expect do
        service.create_feed!
      end.to change(Feed, :count).by(0)
    end
  end
end
