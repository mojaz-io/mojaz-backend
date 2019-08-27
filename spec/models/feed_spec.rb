require "rails_helper"

RSpec.describe Feed, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:url) }

  describe "when valid feed url" do
    it "validates feed url" do
      feed = build(:feed, url: "https://www.7iber.com/feed/")
      allow(feed).to receive(:validate_url)#.and_return(true)
      expect(feed).to be_valid
    end
  end

  describe "when invalid feed url" do
    it "validates feed url" do
      feed = build(:feed, url: "www.google.com")
      allow(feed).to receive(:validate_url) do
        feed.errors.add(:url, "is not a valid rss feed")
      end
      expect(feed).to_not be_valid
    end
  end
end
