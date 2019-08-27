require "rails_helper"

vcr_option = {
  cassette_name: "rss_feeds",
  allow_playback_repeats: "true"
}

RSpec.describe RssReader, vcr: vcr_option do
  let(:link) { "https://www.7iber.com/feed/" }

  describe "#valid_feed_url?" do
    it "returns true on valid feed url" do
      expect(described_class.new.valid_feed_url?(link)).to be true
    end

    it "returns false on invalid feed url" do
      bad_link = "www.google.com"
      expect(described_class.new.valid_feed_url?(bad_link)).to be false
    end
  end
end
