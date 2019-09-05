class LanguageDetector
  def initialize(resource)
    @resource = resource
  end

  def detect
    response = get_language
    response[:code] if response[:reliable]
  rescue StandardError
    nil
  end

  def get_language
    CLD.detect_language(text)
  end

  def text
    return unless @resource.class.name.include?("Feed")

    "#{@resource.title} . #{@resource.description}"
  end
end
