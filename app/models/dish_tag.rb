class DishTag < ActiveRecord::Base
  has_and_belongs_to_many :dishes, :uniq => true
  validates_presence_of :name
  validates_numericality_of :value, :only_integer => true
end
