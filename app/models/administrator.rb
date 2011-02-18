class Administrator < User
  has_many :menus, :dependent => :destroy, :inverse_of => :administrator
end

