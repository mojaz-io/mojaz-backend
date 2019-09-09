require "rails_helper"

RSpec.describe LanguageDetector do
  context "when feed" do
    let(:feed) { build(:feed, title: "Listen to your readers, but don't let them dictate what you create", description: "") }
    let(:feed_1) { build(:feed, title: "C'est vraiment francais, bien oui?") }
    let(:feed_2) { build(:feed, title: "Mauris commodo felis et lacus volutpat fermentum.", description: "") }

    it "detects english" do
      expect(described_class.new(feed).detect).to eq("en")
    end
    it "detects french" do
      expect(described_class.new(feed_1).detect).to eq("fr")
    end
    it "detects nil if non-sensicle" do
      expect(described_class.new(feed_2).detect).to eq(nil)
    end
  end
end
