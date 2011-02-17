class Invitation < ActiveRecord::Base
  RE_EMAIL = /^[A-Z0-9_\.%\+\-]+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2,4}|museum|travel)$/i

  before_create :generate_token
  validates_presence_of :recipient_email
  validates_uniqueness_of :recipient_email, :if => 'recipient_email.present?'
  validates_format_of :recipient_email, :with => RE_EMAIL, :message => "must be a valid email", :if => 'recipient_email.present?'

  private

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end

