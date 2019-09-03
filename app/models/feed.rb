class Feed < ApplicationRecord
  validates :title, :url, presence: true
  validate  :validate_url, if: :url_changed?

  before_create :set_host, if: -> { url.present? }
  before_create :detect_language, if: -> { title.present? }

  def validate_url
    return if url.blank?

    errors.add(:url, "is not a valid rss feed") unless FeedReader.new(url).valid_feed_url?
  end

  def set_host
    self.host = URI.parse(url).host
  rescue URI::InvalidURIError
    Rails.logger.info { "Failed to set host for feed: #{site_url}" }
  end

  # Try to guess the feed language from the title.
  def detect_language
    self.language = LanguageDetector.new(self).detect
  end
end
