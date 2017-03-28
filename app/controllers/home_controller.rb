class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @questions = Question.includes(:user , :answers).all.order(:created_at)

  end

  def create_question
    current_user.questions.create(content: params[:content])
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

end
