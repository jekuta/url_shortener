class Url < ActiveRecord::Base
  validates :url, presence: true, url: true
end
