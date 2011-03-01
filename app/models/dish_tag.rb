class DishTag < ActiveRecord::Base
  has_many :taggings, :inverse_of => :dish_tag, :dependent => :destroy
  has_many :dishes, :through => :taggings, :uniq => true

  attr_accessible :name, :value, :description

  validates_presence_of :name
  validates_numericality_of :value, :only_integer => true

  after_update :log_me

  def to_s
    name
  end

  def log_me
    puts "==========Updating !!!!!=============="
  end
end

