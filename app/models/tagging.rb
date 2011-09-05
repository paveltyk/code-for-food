# encoding: utf-8

class Tagging < ActiveRecord::Base
  belongs_to :dish
  belongs_to :dish_tag

  validates_presence_of :dish, :dish_tag
end

