class Feedback
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :sender, :body
  validates_presence_of :sender, :body

  def persisted?;false;end
end

