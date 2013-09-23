class Image < ActiveRecord::Base
  validates :url, presence: true
  belongs_to :event
end
