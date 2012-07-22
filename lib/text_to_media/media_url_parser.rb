class MediaUrlParser
  EMBEDLY_KEY = "9e226384957f11e1bf614040aae4d8c9"
  URL_REGEX = /http[s]?:\/\/\S+\.(?:com|net|org|biz|in|co|info|gov|ly|me|im)(?:\?.*)?\S{1,}/i
  attr_accessor :original_string, :html, :url, :has_url

  def initialize(original_string)
    self.original_string = original_string
  end

  def contains_url
    self.url = self.original_string.scan(URL_REGEX).first
  end

  def check_for_media
    if contains_url
      self.has_url  = true
      self.html     = parse(embedly_response)
    else
      self.has_url  = false
      self.html     = "<p>#{original_string}</p>"
    end
    self
  end

  def embedly_response
    api = Embedly::API.new(key: EMBEDLY_KEY)
    obj = api.oembed(url: self.url).first
  end

  def parse(embedly_response)
    result = embedly_response
    case result.type
    when 'link'
      self.html = "<a href=#{result.url}>#{self.url.gsub(/http[s]?:\/\//, '')}</a>"
    when 'photo'
      self.html = "<img src=#{result.url}/>"
    when 'video'
      self.html = result.html
    else
      self.html = "N/A"
    end
  end
end