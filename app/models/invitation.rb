class Invitation < ActiveRecord::Base

  attr_accessible :recipient_email

  belongs_to :sender, :class_name => 'Administrator'
  has_one :receiver, :class_name => 'User'

  before_create :generate_token
  validates_presence_of :recipient_email, :sender
  validates_uniqueness_of :recipient_email, :if => 'recipient_email.present?'
  validates_format_of :recipient_email, :with => Authlogic::Regex.email, :message => "must be a valid email", :if => 'recipient_email.present?'

  private

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end

