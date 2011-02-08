ActiveRecord::Schema.define(:version => 20110208140406) do

  create_table "menus", :force => true do |t|
    t.date     "date"
    t.boolean  "locked",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menus", ["date"], :name => "index_menus_on_date"

end
