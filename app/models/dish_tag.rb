class DishTag < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :value, :only_integer => true
end
