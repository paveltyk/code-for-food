require 'machinist/active_record'

Menu.blueprint do
  date { sn.to_i.days.from_now.to_date }
end
