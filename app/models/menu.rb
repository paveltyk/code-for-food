# encoding: utf-8

class Menu < ActiveRecord::Base
  attr_accessible :date, :dishes_attributes

  belongs_to :administrator
  has_many :dishes, :dependent => :destroy, :inverse_of => :menu, :order => 'grade ASC'
  has_many :orders, :dependent => :destroy, :inverse_of => :menu
  validates_presence_of :date, :administrator
  validates_uniqueness_of :date
  accepts_nested_attributes_for :dishes, :allow_destroy => true, :reject_if => :all_blank

  scope :published, where("published_at IS NOT NULL")

  def published?
    !!published_at
  end

  def publish!
    self.published_at = Time.now
    new_record? ? published_at : save
  end

  def to_s
    date ? Russian::strftime(date, Date::DATE_FORMATS[:menu]) : 'unknown'
  end

  def to_param
    self.date.to_s :db
  end
end

