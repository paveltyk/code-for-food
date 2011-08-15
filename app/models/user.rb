class User < ActiveRecord::Base
  acts_as_authentic

  attr_accessor :validate_invitation
  attr_accessible :email, :name, :password, :password_confirmation, :invitation_token, :receive_notifications

  belongs_to :invitation, :dependent => :destroy
  has_many :posts, :inverse_of => :user

  has_many :orders, :dependent => :destroy, :inverse_of => :user do
    def total
      sum(:price)
    end
  end

  has_many :payment_transactions, :inverse_of => :user, :dependent => :destroy do
    def total
      sum(:value)
    end
  end

  with_options :if => 'validate_invitation' do |user|
    user.validates_presence_of :invitation, :message => 'is required'
    user.validates_uniqueness_of :invitation_id, :if => 'invitation.present?'
  end

  def balance
    payment_transactions.total - orders.total
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
  alias_method :screen_name, :to_s
end

