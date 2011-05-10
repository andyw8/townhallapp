ActiveRecord::Schema.define(:version => 20110510200222) do

  create_table "series", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
