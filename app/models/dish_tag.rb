# encoding: utf-8

class DishTag < ActiveRecord::Base
  has_many :taggings, :inverse_of => :dish_tag, :dependent => :destroy
  has_many :dishes, :through => :taggings, :uniq => true

  attr_accessible :name, :value, :description, :operational

  validates_presence_of :name
  validates_numericality_of :value, :only_integer => true, :greater_than_or_equal_to => -100_000, :less_than_or_equal_to => 100_000

  scope :operational, where(:operational => true)

  def name_for_collection_select
    "#{name} (#{value})"
  end

  def to_s
    name
  end
end

