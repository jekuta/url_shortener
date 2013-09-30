class Url < ActiveRecord::Base
  validates :url, presence: true, url: true
  before_create :append_scheme

  # for addresses given without a scheme, e.g. "google.com"
  def append_scheme
    url_address = self.url
    self.url = "http://#{url_address}" unless URI.parse(url_address).scheme
  end
end
