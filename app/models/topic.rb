class Topic < ActiveRecord::Base
  has_many :user_topics
  has_many :topic_question_mappings
end
