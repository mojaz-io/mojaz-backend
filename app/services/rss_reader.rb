class RssReader
  def valid_feed_url?(link)
    true if fetch_rss(link)
  rescue StandardError
    false
  end

  def fetch_rss(url)
    xml = HTTP.get(url).body.to_s
    Feedjira.parse xml
  end
end