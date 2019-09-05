require "rails_helper"

RSpec.describe Feed, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:feed_url) }
  
  # TODO
  # describe "validate uniquness" do
  #   subject { FactoryBot.create(:feed) }
  #   it { is_expected.to validate_uniqueness_of(:feed_url) }
  # end

  describe "when valid feed url" do
    it "validates feed url" do
      feed = build(:feed, feed_url: "https://www.7iber.com/feed/")
      allow(feed).to receive(:validate_feed_url)
      expect(feed).to be_valid
    end
  end

  describe "when invalid feed url" do
    it "validates feed url" do
      feed = build(:feed, feed_url: "www.google.com")
      allow(feed).to receive(:validate_feed_url) do
        feed.errors.add(:url, "is not a valid rss feed")
      end
      expect(feed).not_to be_valid
    end
  end

  describe "#home_page_url" do
    it "returns the correct home_page_url" do
      feed = build(:feed, feed_url: "https://www.7iber.com/feed/")
      allow(feed).to receive(:validate_feed_url).and_return(true)
      feed.save!
      expect(feed.home_page_url).to eq "https://www.7iber.com/"
    end
  end

  describe "#language" do
    it "returns the correct language" do
      feed = build(:feed, feed_url: "https://www.7iber.com/feed/", title: "The Talk Show")
      allow(feed).to receive(:validate_feed_url).and_return(true)
      feed.save!
      expect(feed.language).to eq "en"
    end
  end
end
