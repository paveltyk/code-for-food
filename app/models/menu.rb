class Menu < ActiveRecord::Base
  attr_accessible :date, :dishes_attributes

  belongs_to :administrator
  has_many :dishes, :dependent => :destroy, :inverse_of => :menu
  has_many :orders, :dependent => :destroy, :inverse_of => :menu
  validates_presence_of :date, :administrator
  validates_uniqueness_of :date
  accepts_nested_attributes_for :dishes, :allow_destroy => true, :reject_if => :all_blank

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

  def to_param
    self.date.to_s :db
  end
end

