class Event < ActiveRecord::Base
  has_many :images

  validates :name, presence: true, uniqueness: true
  validates :tag, presence: true, uniqueness: true
end
