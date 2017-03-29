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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170329062608) do

  create_table "answers", force: :cascade do |t|
    t.text     "content"
    t.integer  "question_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"
  add_index "answers", ["user_id"], name: "index_answers_on_user_id"

  create_table "downvote_counts", force: :cascade do |t|
    t.integer  "count"
    t.integer  "answer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "downvote_counts", ["answer_id"], name: "index_downvote_counts_on_answer_id"

  create_table "downvotes", force: :cascade do |t|
    t.integer  "answer_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "downvotes", ["answer_id"], name: "index_downvotes_on_answer_id"
  add_index "downvotes", ["user_id"], name: "index_downvotes_on_user_id"

  create_table "follow_mappings", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "follow_mappings", ["followee_id"], name: "index_follow_mappings_on_followee_id"
  add_index "follow_mappings", ["follower_id"], name: "index_follow_mappings_on_follower_id"

  create_table "questions", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "questions", ["user_id"], name: "index_questions_on_user_id"

  create_table "topic_question_mappings", force: :cascade do |t|
    t.integer  "topic_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "topic_question_mappings", ["question_id"], name: "index_topic_question_mappings_on_question_id"
  add_index "topic_question_mappings", ["topic_id"], name: "index_topic_question_mappings_on_topic_id"

  create_table "topics", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "upvote_counts", force: :cascade do |t|
    t.integer  "count"
    t.integer  "answer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "upvote_counts", ["answer_id"], name: "index_upvote_counts_on_answer_id"

  create_table "upvotes", force: :cascade do |t|
    t.integer  "answer_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "upvotes", ["answer_id"], name: "index_upvotes_on_answer_id"
  add_index "upvotes", ["user_id"], name: "index_upvotes_on_user_id"

  create_table "user_chosen_topics", force: :cascade do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_chosen_topics", ["topic_id"], name: "index_user_chosen_topics_on_topic_id"
  add_index "user_chosen_topics", ["user_id"], name: "index_user_chosen_topics_on_user_id"

  create_table "user_topics", force: :cascade do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_topics", ["topic_id"], name: "index_user_topics_on_topic_id"
  add_index "user_topics", ["user_id"], name: "index_user_topics_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
