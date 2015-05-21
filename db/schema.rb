ActiveRecord::Schema.define(version: 20150519151856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "title",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["title"], name: "index_categories_on_title", unique: true, using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "countries", ["name"], name: "index_countries_on_name", unique: true, using: :btree

  create_table "feeds", force: :cascade do |t|
    t.string   "ig_user",     null: false
    t.integer  "category_id", null: false
    t.integer  "country_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feeds", ["category_id"], name: "index_feeds_on_category_id", using: :btree
  add_index "feeds", ["country_id"], name: "index_feeds_on_country_id", using: :btree
  add_index "feeds", ["ig_user"], name: "index_feeds_on_ig_user", unique: true, using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "post_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "likes", ["post_id"], name: "index_likes_on_post_id", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "thumb_img",    null: false
    t.string   "full_img",     null: false
    t.integer  "feed_id",      null: false
    t.integer  "created_time", null: false
    t.text     "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["created_time"], name: "index_posts_on_created_time", using: :btree
  add_index "posts", ["feed_id"], name: "index_posts_on_feed_id", using: :btree
  add_index "posts", ["full_img"], name: "index_posts_on_full_img", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", using: :btree

end
