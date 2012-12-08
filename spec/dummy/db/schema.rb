# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20121208165553) do

  create_table "tyne_auth_organizations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tyne_auth_users", :force => true do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "username"
    t.string   "email"
    t.string   "token"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "gravatar_id"
  end

  create_table "tyne_core_comments", :force => true do |t|
    t.text     "message"
    t.integer  "issue_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tyne_core_comments", ["issue_id"], :name => "index_tyne_core_comments_on_issue_id"

  create_table "tyne_core_dashboards", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tyne_core_dashboards", ["user_id"], :name => "index_tyne_core_dashboards_on_user_id"

  create_table "tyne_core_issue_priorities", :force => true do |t|
    t.string   "name"
    t.integer  "number"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tyne_core_issue_priorities", ["number"], :name => "index_tyne_core_issue_priorities_on_number"

  create_table "tyne_core_issue_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tyne_core_issues", :force => true do |t|
    t.string   "summary"
    t.text     "description"
    t.integer  "reported_by_id"
    t.integer  "project_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "issue_type_id"
    t.string   "state",             :default => "open"
    t.integer  "number"
    t.integer  "issue_priority_id"
  end

  add_index "tyne_core_issues", ["issue_priority_id"], :name => "index_tyne_core_issues_on_issue_priority_id"
  add_index "tyne_core_issues", ["issue_type_id"], :name => "index_tyne_core_issues_on_issue_type_id"
  add_index "tyne_core_issues", ["number"], :name => "index_tyne_core_issues_on_number"
  add_index "tyne_core_issues", ["project_id"], :name => "index_tyne_core_issues_on_project_id"
  add_index "tyne_core_issues", ["reported_by_id"], :name => "index_tyne_core_issues_on_reported_by_id"

  create_table "tyne_core_projects", :force => true do |t|
    t.string   "name"
    t.string   "key"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
  end

  add_index "tyne_core_projects", ["key"], :name => "index_tyne_core_projects_on_key"
  add_index "tyne_core_projects", ["user_id"], :name => "index_tyne_core_projects_on_user_id"

  create_table "tyne_core_votes", :force => true do |t|
    t.integer  "user_id"
    t.string   "votable_type"
    t.integer  "votable_id"
    t.integer  "weight"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "tyne_core_votes", ["user_id"], :name => "index_tyne_core_votes_on_user_id"
  add_index "tyne_core_votes", ["votable_type", "votable_id"], :name => "index_tyne_core_votes_on_votable_type_and_votable_id"

end
