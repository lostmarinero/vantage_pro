class Image < ActiveRecord::Base
  validates :url, presence: true, uniqueness: true
  belongs_to :event
end
