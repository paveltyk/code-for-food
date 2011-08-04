# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110804080149) do

  create_table "dish_tags", :force => true do |t|
    t.string   "name"
    t.integer  "value",       :default => 0
    t.string   "weight"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "operational", :default => true
  end

  create_table "dishes", :force => true do |t|
    t.integer  "menu_id"
    t.string   "name"
    t.integer  "price"
    t.string   "weight"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_price", :default => 0
    t.string   "grade"
  end

  add_index "dishes", ["menu_id"], :name => "index_dishes_on_menu_id"

  create_table "invitations", :force => true do |t|
    t.integer  "sender_id"
    t.string   "recipient_email"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invitations", ["sender_id"], :name => "index_invitations_on_sender_id"

  create_table "menus", :force => true do |t|
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
    t.integer  "administrator_id"
    t.boolean  "locked"
  end

  add_index "menus", ["administrator_id"], :name => "index_menus_on_administrator_id"
  add_index "menus", ["date"], :name => "index_menus_on_date"

  create_table "order_items", :force => true do |t|
    t.integer  "order_id"
    t.integer  "dish_id"
    t.integer  "quantity",   :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_items", ["dish_id"], :name => "index_order_items_on_dish_id"
  add_index "order_items", ["order_id"], :name => "index_order_items_on_order_id"

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "price",      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "menu_id"
  end

  add_index "orders", ["menu_id"], :name => "index_orders_on_menu_id"
  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "payment_transactions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "value"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payment_transactions", ["user_id"], :name => "index_payment_transactions_on_user_id"

  create_table "posts", :force => true do |t|
    t.string   "type"
    t.integer  "user_id"
    t.text     "body"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "taggings", :force => true do |t|
    t.integer "dish_tag_id"
    t.integer "dish_id"
  end

  add_index "taggings", ["dish_id"], :name => "index_taggings_on_dish_id"
  add_index "taggings", ["dish_tag_id"], :name => "index_taggings_on_dish_tag_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "invitation_id"
    t.string   "type"
    t.boolean  "receive_notifications", :default => true
    t.string   "perishable_token",      :default => "",   :null => false
  end

  add_index "users", ["invitation_id"], :name => "index_users_on_invitation_id"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"

end
