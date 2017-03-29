class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :questions
  has_many :answers
  has_many :upvotes
  has_many :downvotes
  has_many :user_topics

  has_many :follower_mappings, class_name: 'FollowMapping', foreign_key: 'followee_id'
  has_many :followee_mappings, class_name: 'FollowMapping', foreign_key: 'follower_id'
  has_many :followers, through: :follower_mappings
  has_many :followees, through: :followee_mappings

  def feed
    topicsChosen = user_topics.pluck(:topic_id)
    questionsChosen = TopicQuestionMapping.where("topic_id in (?)" , topicsChosen)
    questions_ids = questionsChosen.pluck(:question_id)
    users = followees.pluck(:id)
    questions = Question.includes(:user, :answers).where("id in (?)",questions_ids) + Question.includes(:user, :answers).where("user_id in (?)",users)
    questions = questions.uniq
    # questions.sort_by {|obj| obj.id}
    questions.shuffle!
  end

end
