module Zoofs
  module Parsers
    class TheVerge < Parser
      homepage "https://www.theverge.com".freeze

      # The Verge content is contained inside a div
      # We need to extract the first level p and ignore everything else
      #
      # <div class="c-entry-content ">
      #   <p id="8beXKk">p1</p>
      #   <p id="zakf8S">p2</p>
      #   <aside id="9kcczP">
      #     <div class="c-read-more">
      #       <p class="c-read-more__intro">Related</p>
      #       <h4><a href="#">link</a></h4>
      #     </div>
      #   </aside>
      #   <p id="8tEXMr">p3</p>
      # </div>
      content_formulas Hash[
        "css", "div.c-entry-content > p"
      ].freeze

      #
      # <figure class="e-image e-image--hero">
      #   <span class="e-image__inner">
      #     <span class="e-image__image " data-original="#">
      #         <picture class="c-picture">
      #           <source srcset="#">
      #           <img srcset="#">
      #         </picture>
      #     </span>
      #   </span>
      #   <span class="e-image__meta">
      #     <cite>Photo by Amelia Holowaty Krales / The Verge</cite>
      #   </span>
      # </figure>
      image_formulas Hash[
        "css", "figure.e-image  picture img/@src"
      ].freeze
    end
  end
end
