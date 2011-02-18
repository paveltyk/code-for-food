class User < ActiveRecord::Base
  acts_as_authentic

  attr_accessor :validate_invitation
  attr_accessible :email, :name, :password, :password_confirmation, :invitation_token

  has_many :orders, :inverse_of => :user
  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => :sender_id
  belongs_to :invitation

  with_options :if => 'validate_invitation' do |user|
    user.validates_presence_of :invitation, :message => 'is required'
    user.validates_uniqueness_of :invitation_id, :if => 'invitation.present?'
  end

  def invitation_token
    invitation.token if @invitation
  end

  def invitation_token=(token)
    self.invitation = Invitation.find_by_token(token)
  end
end

