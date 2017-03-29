class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :upvotes
  has_many :downvotes
  has_one :upvote_count
  has_one :downvote_count
  has_many :comments
end
