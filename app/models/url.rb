class Url < ActiveRecord::Base
  validates :url, presence: true, url: true
  before_create :append_scheme

  def append_scheme
    self.url = "http://#{self.url}" unless URI.parse(self.url).scheme
  end
end
