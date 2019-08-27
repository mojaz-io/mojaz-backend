class RssReader
  def valid_feed_url?(link)
    true if fetch_rss(link)
  rescue StandardError
    false
  end

  def fetch_rss(url)
    xml = HTTP.follow(max_hops: 3).get(url).body.to_s
    Feedjira.parse xml
  end
end
