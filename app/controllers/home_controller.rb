class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @questions = current_user.feed
  end

  def create_question
    topic = params[:topic]
    question = current_user.questions.create(content: params[:content])
    topic = topic.to_s.downcase
    topicsAll = Topic.all
    flag = 0
    topicsAll.each do |existingTopic|
      if topic == existingTopic.content.to_s.downcase
        existingTopic.topic_question_mappings.create(question_id: question.id)
        flag = 1
        break
      end
    end
    if flag == 0
      newTopic = Topic.create(content: params[:topic])
      newTopic.topic_question_mappings.create(question_id: question.id)
    end
    return redirect_to '/'
  end

  def create_answer
    answer = params[:answer]
    question_id = params[:question_id]
    answer = current_user.answers.create(content: answer , question_id: question_id)
    UpvoteCount.create(answer_id: answer.id , count: 0)
    DownvoteCount.create(answer_id: answer.id , count: 0)
    return redirect_to '/'
  end

  def upvote
    answer_id = params[:answer_id]
    upvote = current_user.upvotes.where(answer_id: answer_id).first
    if upvote
      upvote.destroy
      count = UpvoteCount.find_by_answer_id(answer_id)
      count.count = count.count - 1
      count.save
    else
      current_user.upvotes.create(answer_id: answer_id)
      count = UpvoteCount.find_by_answer_id(answer_id)
      count.count = count.count + 1
      count.save
    end
    return redirect_to '/'
  end

  def downvote
    answer_id = params[:answer_id]
    downvote = current_user.downvotes.where(answer_id: answer_id).first
    if downvote
      downvote.destroy
      count = DownvoteCount.find_by_answer_id(answer_id)
      count.count = count.count - 1
      count.save
    else
      current_user.downvotes.create(answer_id: answer_id)
      count = DownvoteCount.find_by_answer_id(answer_id)
      count.count = count.count + 1
      count.save
    end
    return redirect_to '/'
  end

  def topics
    @topicsAll = Topic.all.order(:content)

    @topicsNotFollowing = []
    @topicsFollowing = []

    @topicsAll.each do |topic|
      @topicsNotFollowing.push(topic)
    end

    @topicsAll.each do |topic|
      if topic.user_topics.where(user_id: current_user.id).length > 0
        @topicsNotFollowing.delete(topic)
        @topicsFollowing.push(topic)
      end
    end
  end

  def add_topic
    all_topics = params[:topic_ids].collect {|id| id.to_i} if params[:topic_ids]
    # all_topics = params[:topics]
    all_topics.each do |topic|
      current_user.user_topics.create(topic_id: topic)
    end
    return redirect_to '/topics'
  end

  def remove_topic
    all_topics = params[:topic_ids].collect {|id| id.to_i} if params[:topic_ids]
    all_topics.each do |topic|
      mapping = UserTopic.where(topic_id: topic , user_id: current_user.id).first
      mapping.destroy
    end
    return redirect_to '/topics'
  end

  def follow
    followee_id = params[:followee_id]
    follow_mapping = FollowMapping.where(:follower_id => current_user.id, :followee_id => followee_id).first
    unless follow_mapping
      FollowMapping.create(:follower_id => current_user.id, :followee_id => followee_id)
    else
      follow_mapping.destroy
    end

    return redirect_to '/users'
  end

  def users
    @users = User.where('id != ?', current_user.id)
  end

  def followers
    @users = current_user.followers
  end

  def followees
    @users = current_user.followees
  end

  def question_display
    @question = Question.find(params[:question])
  end

  def create_comment
    answer_id = params[:answer_id]
    question_id = params[:question_id]
    content = params[:comment]
    Comment.create(answer_id: answer_id , content: content)
    return redirect_to url_for(controller: :home , action: :question_display , question: question_id )
  end

  def profile
  end

  # added picture
  def update_profile
    name = params["name"]
    current_user.name = name
    p = params["profile_picture"]
    new_filename = SecureRandom.hex + "." + p.original_filename.split(".")[1]

    File.open(Rails.root.join('public', 'uploads', new_filename), 'wb') do |file|
      file.write(p.read)
    end

    current_user.profile_picture = new_filename
    current_user.save
    redirect_to :profile
  end

end
