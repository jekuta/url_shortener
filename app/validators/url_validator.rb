class UrlValidator < ActiveModel::EachValidator
  require 'uri'

  def validate_each(record, attribute, value)
    uri = URI.parse(value)
    unless uri.kind_of?(URI::HTTP)
      record.errors[attribute] << (options[:message] || "Is not a valid url")
    end
  end
end
