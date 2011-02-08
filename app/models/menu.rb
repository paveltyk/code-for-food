class Menu < ActiveRecord::Base
  has_many :dishes, :dependent => :destroy
  validates_presence_of :date
  validates_uniqueness_of :date

  def published?
    !!published_at
  end

  def publish!
    self.published_at = Time.now
    save unless new_record?
    published_at
  end
end
