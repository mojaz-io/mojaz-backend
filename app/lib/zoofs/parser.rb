# frozen_string_literal: true

require_relative "extend/module"

module Zoofs
  class Parser
    extend Forwardable

    attr_reader :url
    attr_reader :doc
    attr_reader :content_response, :image_response, :video_response

    # The homepage for the feed.
    # @method homepage
    # @see .homepage=
    delegate homepage: :"self.class"

    # The content_formulas to parse the content.
    # @method content_formulas
    # @see .content_formula=
    delegate content_formulas: :"self.class"

    # The image_formulas to parse the content.
    # @method image_formulas
    # @see .image_formulas=
    delegate image_formulas: :"self.class"

    # The video_formulas to parse the content.
    # @method video_formulas
    # @see .video_formula=
    delegate video_formulas: :"self.class"

    VALID_FORMULA_TYPES = %w[css xpath].freeze

    def initialize(url)
      @url = url
      @doc = Nokogiri::HTML(content)
    end

    def parse
      @content_response = parse_formulas(content_formulas)
      @image_response = parse_formulas(image_formulas)
      @video_response = parse_formulas(video_formulas)

      Response.new(@content_response, @image_response, @video_response)
    end

    class << self
      # @!attribute [w] homepage
      # The homepage for the Feed.
      #
      # <pre>homepage "http://www.bbc.com"</pre>
      attr_rw :homepage

      # @!attribute [w] content_formulas
      # The content_formulas for the Feed.
      #
      # <pre>
      # content_formulas Hash[
      #   "css", ["div.story-body__inner p", "div.story-body p"]
      # ].freeze
      # </pre>
      attr_rw :content_formulas

      # @!attribute [w] image_formulas
      # The image formulas for the Feed.
      #
      # <pre>
      # image_formulas Hash[
      #   "css", ["div.story-body__inner p", "div.story-body p"]
      # ].freeze
      # </pre>
      attr_rw :image_formulas

      # @!attribute [w] video_formulas
      # The video formulas for the Feed.
      #
      # <pre>
      # video_formulas Hash[
      #   "css", ["div.story-body__inner p", "div.story-body p"]
      # ].freeze
      # </pre>
      attr_rw :video_formulas

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

    def parse_formulas(formulas)
      return {} if formulas.nil?

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
          response[name] = execute_formula(name, formula)
        end
      end

      response
    end

    def execute_formula(name, forumla)
      @doc.send(name, forumla)
    end
  end
end
