class MediaUrlParser
  EMBEDLY_KEY = "9e226384957f11e1bf614040aae4d8c9"
  URL_REGEX = /http[s]?:\/\/\S+\.(?:com|net|org|biz|in|co|info|gov|ly|me|im)(?:\?.*)?\S{1,}/i
  attr_accessor :original_string, :html, :url, :has_url, :display_html

  def initialize(original_string)
    self.original_string = original_string
  end

  def contains_url
    self.url = self.original_string.scan(URL_REGEX).first
  end

  def check_for_media
    if contains_url
      self.has_url      = true
      self.html         = parse(embedly_response)
      self.display_html = format_with_original_message
    else
      self.has_url      = false
      self.html         = "<p>#{original_string}</p>"
      self.display_html = "<p>#{original_string}</p>"
    end
    self
  end

  def format_with_original_message
    html_style = "</br>#{self.html}</br>"
    self.original_string.gsub(URL_REGEX, html_style)
  end

  def embedly_response
    api = Embedly::API.new(key: EMBEDLY_KEY)
    obj = api.oembed(url: self.url).first
  end

  def parse(embedly_response)
    result = embedly_response
    case result.type
    when 'link'
      self.html = "<a href=#{result.url} target="_blank">#{self.url.gsub(/http[s]?:\/\//, '')}</a>"
    when 'photo'
      self.html = "<img src='#{result.url}'/>"
    when 'video'
      self.html = result.html
    else
      self.html = "<p>Unable to find content for url<p>"
    end
  end
end