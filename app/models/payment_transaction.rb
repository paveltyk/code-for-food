class PaymentTransaction < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user
  validates_numericality_of :value, :only_integer => true, :greater_than => -1_000_000, :less_than => 1_000_000

  default_scope order('created_at DESC')
  def to_s
    Russian::strftime created_at, "%d %B %Y"
  end
end

