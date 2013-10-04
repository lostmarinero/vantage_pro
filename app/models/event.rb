class Event < ActiveRecord::Base
  has_many :images

  validates :name, presence: true, uniqueness: true
  validates :tag, presence: true, uniqueness: true

  before_create :downcase_tag


  protected

  def downcase_tag
    self.tag.downcase!
  end
end
