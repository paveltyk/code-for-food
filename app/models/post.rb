# encoding: utf-8

class Post < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :body, :user
end

