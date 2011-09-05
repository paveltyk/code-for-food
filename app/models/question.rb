# encoding: utf-8

class Question < Post
  has_many :answers, :inverse_of => :question
  validate :questionb_id_should_be_blank

  private

  def questionb_id_should_be_blank
    errors.add(:question_id, 'should be blank') if question_id.present?
  end
end

