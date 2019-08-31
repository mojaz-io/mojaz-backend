require_relative "converters/youtube"

module Zoofs
  class Response
    attr_reader :content_formulas_res, :image_formulas_res, :video_formulas_res

    PARAGRAPH_SEPERATOR = "~".freeze

    def initialize(content_formulas_res = {}, image_formulas_res = {}, video_formulas_res = {})
      @content_formulas_res = content_formulas_res
      @image_formulas_res = image_formulas_res
      @video_formulas_res = video_formulas_res
    end

    def body
      @body ||= @content_formulas_res.values.flatten.map { |element| element.text.strip }.join(PARAGRAPH_SEPERATOR)
    end

    def image_src
      @image_src ||= @image_formulas_res.values.flatten.map { |element| element.text.strip }.first
    end

    def video_src
      @video_src ||= @video_formulas_res.values.flatten.map { |element| element.text.strip }.first
    end

    # def youtube_link
    #   return @youtube_link if @youtube_link

    #   href = nil
    #   @content_formulas_res.values.flatten.each do |x|
    #     href = x.xpath("a/@href'").text if Zoofs::Converters::Youtube.youtube?(x.xpath("a/@href").text)
    #   end

    #   @youtube_link ||= href
    # end

    # def to_h
    #   {
    #     body: body,
    #     youtube: Zoofs::Converters::Youtube.new(youtube_link)
    #   }
    # end
  end
end
