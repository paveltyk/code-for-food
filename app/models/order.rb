class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :menu
  validates_presence_of :user, :menu
end

