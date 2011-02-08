class Menu < ActiveRecord::Base
  has_many :dishes, :dependent => :destroy
  validates_presence_of :date
  validates_uniqueness_of :date
end
