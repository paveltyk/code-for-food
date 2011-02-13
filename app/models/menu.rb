class Menu < ActiveRecord::Base
  has_many :dishes, :dependent => :destroy, :inverse_of => :menu
  validates_presence_of :date
  validates_uniqueness_of :date
  accepts_nested_attributes_for :dishes

  def published?
    !!published_at
  end

  def publish!
    self.published_at = Time.now
    save unless new_record?
    published_at
  end

  def to_s
    date ? date.to_s(:menu) : 'unknown'
  end
end

