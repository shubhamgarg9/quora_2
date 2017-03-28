class CreateTopicQuestionMappings < ActiveRecord::Migration
  def change
    create_table :topic_question_mappings do |t|
      t.references :topic, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
