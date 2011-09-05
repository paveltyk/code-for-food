# encoding: utf-8

class Answer < Post
  belongs_to :question
  validates_presence_of :question
end

