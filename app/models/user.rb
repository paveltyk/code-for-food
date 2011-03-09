class User < ActiveRecord::Base
  acts_as_authentic do |config|
    config.require_password_confirmation = false
  end

  attr_accessor :validate_invitation
  attr_accessible :email, :name, :password, :password_confirmation, :invitation_token

  has_many :orders, :dependent => :destroy, :inverse_of => :user
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

  def self.inherited(child)
    child.instance_eval do
      def model_name
        User.model_name
      end
    end
    super
  end

  def to_s
    self.name.present? ? name : (email || '').split('@').first
  end
end

