require 'machinist/active_record'

Menu.blueprint do
  date { sn.to_i.days.from_now.to_date }
end

Dish.blueprint do
  menu
  name { "Dish #{sn}" }
  price { 3000 + rand(30)*100 }
end

DishTag.blueprint do
  name { "dish-tag-#{sn}" }
end

Invitation.blueprint do
  recipient_email { "email.#{sn}@test.com" }
end

