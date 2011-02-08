class Menu < ActiveRecord::Base
  validates_presence_of :date
  validates_uniqueness_of :date 
end
