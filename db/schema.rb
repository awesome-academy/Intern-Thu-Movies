# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_28_030812) do

  create_table "cast_movies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "cast_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cast_id"], name: "index_cast_movies_on_cast_id"
    t.index ["movie_id"], name: "index_cast_movies_on_movie_id"
  end

  create_table "casts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "cast_name"
    t.date "birthday"
    t.string "birthplace"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "content"
    t.bigint "user_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_comments_on_movie_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favoriate_movies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "user_id", null: false
    t.integer "type", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_favoriate_movies_on_movie_id"
    t.index ["user_id"], name: "index_favoriate_movies_on_user_id"
  end

  create_table "genres", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "genre_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "movies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.string "image_url"
    t.string "background_image"
    t.string "slug"
    t.text "overview"
    t.string "source_movie"
    t.string "trailer"
    t.date "release_date"
    t.string "runtime"
    t.string "director"
    t.bigint "genre_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genre_id"], name: "index_movies_on_genre_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.string "avatar_url"
    t.integer "role", default: 0
    t.boolean "activated", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
  end

  add_foreign_key "cast_movies", "casts"
  add_foreign_key "cast_movies", "movies"
  add_foreign_key "comments", "movies"
  add_foreign_key "comments", "users"
  add_foreign_key "favoriate_movies", "movies"
  add_foreign_key "favoriate_movies", "users"
  add_foreign_key "movies", "genres"
end
