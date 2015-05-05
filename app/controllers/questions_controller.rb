class QuestionsController < ApplicationController

include HTTParty


  def index
    @questions = Question.all
    @question = Question.new
    response = HTTParty.get('https://api.github.com/zen')
    parsed = JSON.parse(response.body)
    if parsed["message"]
      @quote = ["Don't half-ass it.", "Whether you think you can or you think you can't, you're right.", "Millions of peaches. Peaches for me."].sample
    else
      @quote = response.body
    end
  end

  def show
    @question = Question.where(id: params[:id]).first
  end

  def create
        p "*" *100
    p question_params
    @question = Question.new(question_params)
    if @question.save
      redirect_to root_path
    else
      status 406
      render :index
    end
  end

  def edit
    @question = Question.where(id: params[:id]).first
    render  :edit
  end

  def update
    question = Question.where(id: params[:id]).first
    question.update(question_params)
    redirect_to root_path
  end

  def destroy
    q_to_destroy = Question.where(id: params[:id]).first
    q_to_destroy.destroy
    redirect_to root_path
  end

  def upvote
    question = Question.where(id: params[:id]).first
    question.votes += 1
    question.save
    redirect_to root_path
  end

  def downvote
    question = Question.where(id: params[:id]).first
    question.votes -= 1
    question.save
    redirect_to root_path
  end

  def question_params
    params.require(:question).permit(:title, :content)
  end

end
