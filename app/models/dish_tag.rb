class DishTag < ActiveRecord::Base
  has_and_belongs_to_many :dishes, :uniq => true

  attr_accessible :name, :value, :description

  validates_presence_of :name
  validates_numericality_of :value, :only_integer => true

  def to_s
    name
  end
end

