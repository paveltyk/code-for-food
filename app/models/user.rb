# encoding: utf-8

class User < ActiveRecord::Base
  acts_as_authentic

  attr_accessor :validate_invitation
  attr_accessible :email, :name, :password, :password_confirmation, :invitation_token,
                  :receive_notifications, :receive_forum_notifications

  belongs_to :invitation, :dependent => :destroy
  has_many :posts, :inverse_of => :user

  has_many :orders, :dependent => :destroy, :inverse_of => :user

  has_many :payment_transactions, :inverse_of => :user, :dependent => :destroy

  with_options :if => 'validate_invitation' do |user|
    user.validates_presence_of :invitation, :message => 'is required'
    user.validates_uniqueness_of :invitation_id, :if => 'invitation.present?'
  end

  # Define <tt>orders_total</tt> and <tt>payment_transactions_total</tt>
  # methods. They'll use Rails' cache if it's available.
  {:orders => :price, :payment_transactions => :value}.each do |rel, field|
    method_name = "#{rel}_total"
    if Rails.cache
      define_method(method_name) do
        cache_key = "#{method_name}:#{id}"
        unless value = Rails.cache.read(cache_key)
          value = self.send(rel).sum(field)
          Rails.cache.write(cache_key, value)
        end
        value
      end
    else
      define_method(method_name) do
        orders.sum(field)
      end
    end
  end.keys.tap do |rels|
    define_method(:sweep_cached_totals) do
      if Rails.cache
        rels.map do |rel|
          Rails.cache.delete("#{rel}_total:#{id}")
        end
      end
    end
  end

  def balance
    payment_transactions_total - orders_total
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

