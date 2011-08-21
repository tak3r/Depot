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

ActiveRecord::Schema.define(:version => 20110815143152) do

  create_table "employees", :force => true do |t|
    t.string   "name"
    t.date     "dob"
    t.decimal  "salary",     :precision => 8, :scale => 2
    t.string   "job"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.decimal  "credit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "summaries", :force => true do |t|
    t.integer  "timesheet_id"
    t.string   "cached_content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timesheets", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.date     "start_date"
  end

  create_table "work_days", :force => true do |t|
    t.date     "day"
    t.text     "comment"
    t.integer  "timesheet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "employee_id"
  end

end
