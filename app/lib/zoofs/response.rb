require_relative "converters/youtube"

module Zoofs
  class Response
    attr_reader :formulas_response

    PARAGRAPH_SEPERATOR = "~".freeze

    def initialize(formulas_response = {})
      @formulas_response = formulas_response
    end

    def body
      @body ||= @formulas_response.values.flatten.reduce("") { |str, element| str + element.text }
    end

    def youtube_link
      return @youtube_link if @youtube_link

      href = nil
      @formulas_response.values.flatten.each do |x|
        href = x.xpath("a/@href'").text if Zoofs::Converters::Youtube.youtube?(x.xpath("a/@href").text)
      end

      @youtube_link ||= href
    end

    def to_h
      {
        body: body,
        youtube: Zoofs::Converters::Youtube.new(youtube_link)
      }
    end
  end
end
