class WebsiteLogoService
  attr_reader :home_url

  def initialize(home_url = nil)
    @home_url = home_url
  end

  def call
    find_media_link
  end

  private

  def find_media_link
    return unless @home_url

    response = HTTP.follow(max_hops: 3).timeout(3).get(@home_url)
    html = Nokogiri::HTML(response.to_s)
    links = html.search(xpath)
    link = find_biggest_option(links)
    return unless link

    fix_link_relative_path(link, response.uri.to_s)
  end

  def xpath
    icon_names = ["icon", "shortcut icon", "apple-touch-icon-precomposed", "apple-touch-icon"]
    icon_names = icon_names.map do |icon_name|
      "//link[not(@mask) and translate(@rel, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = '#{icon_name}']"
    end
    icon_names.join(" | ")
  end

  def find_biggest_option(links)
    return if links.empty?

    # Try to find the best option based on size
    link = find_based_on_size(links)
    return link["href"] if link

    # Apple icons tends to have the best images, try to find one.
    link = find_based_on_apple_rel(links)
    return link["href"] if link

    # We couldn't determine which one is the best, so use the last one on the array
    links.last["href"]
  end

  def find_based_on_size(links)
    # Exact all the sizes including the nils.
    # [nil, "16x16", "32x32", "96x96", "192x192", "180x180"]
    sizes = links.map { |x| x["sizes"] }

    # Compact the array and check if it's empty, then we don't have sizes
    # and we need to for another way.
    return if sizes.compact.empty?

    # 1. map the array elements and convert them to width only, nil will be 0
    # [nil, "16x16", "32x32", "96x96", "192x192", "180x180"] => [0, 16, 32, 96, 192, 180]
    # 2. find the index of the biggest width in the array
    index = sizes.map { |x| x.to_s.split("x").first.to_i }.each_with_index.max[1]
    return links[index] if index
  end

  def find_based_on_apple_rel(links)
    apple_name = %w[apple-touch-icon-precomposed apple-touch-icon]
    apple = links.detect { |x| apple_name.include?(x["rel"].downcase) }
    return apple if apple
  end

  # Some links when extracted from the page have relative paths
  # we need to fixed them by attaching the host and schema if needed.
  def fix_link_relative_path(link, domain_uri)
    fixed = URI.parse(link)
    return link if fixed.host && fixed.scheme

    original_domain = URI.parse(domain_uri)
    fixed.host = original_domain.host unless fixed.host
    fixed.scheme = original_domain.scheme unless fixed.scheme
    fixed.to_s
  end
end
