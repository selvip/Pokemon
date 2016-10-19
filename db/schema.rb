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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161018073940) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pokedexes", force: :cascade do |t|
    t.string   "name"
    t.integer  "base_health_point"
    t.integer  "base_attack"
    t.integer  "base_defence"
    t.integer  "base_speed"
    t.string   "element_type"
    t.string   "image_url"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "pokemon_skills", force: :cascade do |t|
    t.integer  "skill_id"
    t.integer  "pokemon_id"
    t.integer  "current_pp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pokemons", force: :cascade do |t|
    t.integer  "pokedex_id"
    t.string   "name"
    t.integer  "level"
    t.integer  "max_health_point"
    t.integer  "current_health_point"
    t.integer  "attack"
    t.integer  "defence"
    t.integer  "speed"
    t.integer  "current_experience"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.integer  "power"
    t.integer  "max_pp"
    t.string   "element_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
