class CreateUserTopics < ActiveRecord::Migration
  def change
    create_table :user_topics do |t|
      t.references :topic, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
