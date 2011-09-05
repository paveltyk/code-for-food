# encoding: utf-8

class Feedback
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :sender, :body
  validates_presence_of :sender, :body, :message => 'не может быть пустым'

  def initialize(attrs = {})
    attrs ||= {}
    self.body = attrs[:body]
  end

  def deliver
    return false unless valid?
    !!Mailer.feedback(self).deliver
  end

  def persisted?;false;end
end

