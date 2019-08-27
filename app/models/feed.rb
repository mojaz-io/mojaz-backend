class Feed < ApplicationRecord
  validates :title, :description, :url, presence: true
  validate  :validate_url, if: :url_changed?

  def validate_url
    return if url.blank?

    errors.add(:url, "is not a valid rss feed") unless RssReader.new.valid_feed_url?(url)
  end
end
