class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  has_many :answers
  has_one :topic_question_mapping
end
