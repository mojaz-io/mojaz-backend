module Zoofs
  module Parsers
    class Bbc < Parser
      homepage "http://www.bbc.co.uk".freeze

      # @TODO: Check why using normal hash syntax {} doesn't work, i have no idea.
      formulas Hash[
        "content", "css('div.story-body__inner p')",
        "media", "css('div.story-body p')"
      ].freeze
    end
  end
end
