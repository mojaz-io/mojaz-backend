class Feed < ApplicationRecord
  validates :title, :feed_url, presence: true
  validate  :validate_feed_url, if: :feed_url_changed?

  validates :feed_url, uniqueness: true

  before_create :set_home_page_url, if: -> { home_page_url.blank? && feed_url.present? }
  before_create :detect_language, if: -> { title.present? }

  def validate_feed_url
    return if feed_url.blank?

    errors.add(:feed_url, "is not a valid feed") unless FeedReader.new(feed_url).valid_feed_url?
  end

  def set_home_page_url
    self.home_page_url = URI.join(feed_url, "/").to_s
  rescue URI::InvalidURIError
    Rails.logger.info { "Failed to set home_page_url for feed: #{feed_url}" }
  end

  # Try to guess the feed language from the title.
  def detect_language
    self.language = LanguageDetector.new(self).detect
  end
end
