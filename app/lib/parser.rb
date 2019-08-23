# frozen_string_literal: true

require_relative "extend/module"

class Parser
  extend Forwardable

  # The homepage for the feed.
  # @method homepage
  # @see .homepage=
  delegate homepage: :"self.class"

  class << self
    # @!attribute [w] homepage
    # The homepage for the Feed.
    #
    # <pre>homepage "http://www.bbc.com"</pre>
    attr_rw :homepage
  end
end
