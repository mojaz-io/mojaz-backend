module Zoofs
  module Parsers
    class Bbc < Parser
      homepage "http://www.bbc.co.uk".freeze

      # @TODO: Check why using normal hash syntax {} doesn't work, i have no idea.
      content_formulas Hash[
        "css", ["div.story-body__inner p", "div.story-body p"]
      ].freeze

      image_formulas Hash[
        "css", ["meta[property='og:image']/@content", "div.story-body__inner figure img/@src"]
      ].freeze

      # video_formulas Hash[
      #   "css", ["meta[name='twitter:player']/@content"]
      # ].freeze
    end
  end
end
