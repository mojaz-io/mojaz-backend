class FeedReader
  attr_reader :url

  def initialize(url)
    @url = url
  end

  # Create Feed if it doesn't exits.
  def create_feed!
    feed = find_feed_locally(@url)

    # If we already have this feed, then just return it.
    return feed if feed

    # Fetch the feed from remote and try to parse it using the defined parsers.
    parser = fetch_feed

    # Again, check the localDB for a feed matching the final url in case of redirection
    # For example: if the url: https://www.7iber.com/feed
    # it will be redirected to to https://www.7iber.com/feed/
    feed = find_feed_locally(remote_response.uri.to_s)
    return feed if feed

    create_feed_from_parser(parser)
  end

  #
  # Check if the feed url is valid by either:
  # 1. Checking the local db
  # 2. Trying to check if we have a valid parser for the incoming url.
  #
  def valid_feed_url?
    true if find_feed_locally(@url) || fetch_feed
  rescue StandardError
    false
  end

  private

  def fetch_feed
    Feedjira.parse remote_response.body.to_s
  end

  def remote_response
    @remote_response ||= HTTP.follow(max_hops: 3).get(@url)
  end

  def find_feed_locally(link)
    Feed.where(feed_url: link).take
  end

  def create_feed_from_parser(parser)
    Feed.create!(
      feed_url: remote_response.uri,
      title: parser.title,
      description: parser.description,
      etag: remote_response.headers["Etag"],
      last_modified: remote_response.headers["Last-Modified"],
      home_page_url: parser.url,
    )
  end
end
