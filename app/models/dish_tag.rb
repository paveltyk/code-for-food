class DishTag < ActiveRecord::Base
  has_many :taggings, :inverse_of => :dish_tag, :dependent => :destroy
  has_many :dishes, :through => :taggings, :uniq => true

  attr_accessible :name, :value, :description

  validates_presence_of :name
  validates_numericality_of :value, :only_integer => true

  def name_for_collection_select
    "#{name} (#{value})"
  end

  def to_s
    name
  end
end

