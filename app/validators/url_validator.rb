class UrlValidator < ActiveModel::EachValidator
  require 'net/http'

  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "must be a valid URL") unless url_valid?(value)
  end

  def url_valid?(url)
    url = URI.parse(url) rescue false
    if !url.blank? && !url.scheme
      url_valid?("http://#{url}")
    else
      ( url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS) ) && valid_domain_name?(url.host)
    end
  end

  def valid_domain_name?(host)
    # regexp from: http://stackoverflow.com/a/13311941
    host =~ /^(http|https):\/\/|[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/
  end
end
