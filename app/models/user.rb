class User < ActiveRecord::Base
  acts_as_authentic

  attr_accessible :email, :name, :password, :password_confirmation, :invitation_token

  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => :sender_id
  belongs_to :invitation
end

