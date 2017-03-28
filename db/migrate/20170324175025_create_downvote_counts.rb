class CreateDownvoteCounts < ActiveRecord::Migration
  def change
    create_table :downvote_counts do |t|
      t.integer :count
      t.references :answer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
