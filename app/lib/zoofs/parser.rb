# frozen_string_literal: true

require_relative "extend/module"

module Zoofs
  class Parser
    extend Forwardable

    attr_reader :url
    attr_reader :doc

    # The homepage for the feed.
    # @method homepage
    # @see .homepage=
    delegate homepage: :"self.class"

    # The formulas to parse the content.
    # @method formula
    # @see .formula=
    delegate formulas: :"self.class"

    VALID_FORMULA_TYPES = ["css", "xpath"].freeze

    def initialize(url)
      @url = url
      @doc = Nokogiri::HTML(content)
    end

    def parse
      raise "You need to define a formula or implement a custom parse function" unless formulas

      parse_formulas
    end

    class << self
      # @!attribute [w] homepage
      # The homepage for the Feed.
      #
      # <pre>homepage "http://www.bbc.com"</pre>
      attr_rw :homepage

      # @!attribute [w] formulas
      # The formulas for the Feed.
      #
      # <pre>
      # formulas Hash[
      #   "content", "css('div.story-body__inner p')",
      #   "media", "css('div.story-body p')"
      # ]
      # </pre>
      attr_rw :formulas

      def can_parse?(url)
        url.match? %r{^#{homepage}}
      end
    end

    private

    def content
      return @content if @content

      response = HTTP.follow(max_hops: 3).get(url)
      raise "Failed to fetch url" unless response.status.success?

      @content = response.body.to_s
    end

    def parse_formulas
      response = {}
      formulas.each do |name, formula|
        # Skip the formula as it's not supported.
        next unless VALID_FORMULA_TYPES.include?(name)
        if formula.is_a?(Array)
          # Initialize that forumla response to array
          response[name] = []
          formula.each { |f| response[name] << execute_formula(name, f) }
          response[name].flatten!
        elsif formula.is_a?(String)
          
        end

        # response[name] = eval("@doc.#{formula}")
      end
      Response.new(response)
    end

    def execute_formula(name, f)
      puts "Executing #{name} with: #{f}"
      @doc.send(name, f)
    end
  end
end
