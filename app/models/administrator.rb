class Administrator < User
  has_many :menus, :dependent => :destroy, :inverse_of => :administrator
  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => :sender_id
end

