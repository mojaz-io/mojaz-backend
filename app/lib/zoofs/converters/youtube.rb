module Zoofs
  module Converters
    class Youtube
      YOUTUBE_REGEX = /^(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?([\w-]{10,})/.freeze

      def initialize(url)
        @url = url
        @video_id = url.match(YOUTUBE_REGEX)[1]
      end

      class << self
        # Check if a url is video url
        def youtube?(url)
          url.match?(YOUTUBE_REGEX)
        end
      end
    end
  end
end
