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

ActiveRecord::Schema.define(version: 20170529020115) do

  create_table "auctions", force: :cascade do |t|
    t.string "results"
  end

  create_table "rejections", force: :cascade do |t|
    t.integer "student_id"
    t.integer "school_id"
  end

  create_table "school_prefs", force: :cascade do |t|
    t.integer "school_id"
    t.integer "student_id"
    t.integer "rank"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.integer "zone"
    t.integer "capacity"
    t.integer "availability"
  end

  create_table "student_prefs", force: :cascade do |t|
    t.integer "school_id"
    t.integer "student_id"
    t.integer "rank"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.integer "zone"
    t.integer "test_score"
    t.integer "school_id"
    t.boolean "assigned", default: false
  end

end
