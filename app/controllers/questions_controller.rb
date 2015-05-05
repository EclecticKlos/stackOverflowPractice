class QuestionsController < ApplicationController

include HTTParty
require 'dotenv'
Dotenv.load

QUOTE_URI = 'https://api.github.com/zen'
QUOTE_URI_WITH_QUERY = (QUOTE_URI + "?client_id=" + ENV['GITHUB_CLIENT_ID'] + "&client_secret=" + ENV['GITHUB_CLIENT_SECRET']).to_s

  def index
    @questions = Question.all
    @question = Question.new
    response = HTTParty.get(QUOTE_URI_WITH_QUERY)
    if response.body[2] == 'm'
      @quote = ["Don't half-ass it.", "Whether you think you can or you think you can't, you're right.", "Millions of peaches. Peaches for me."].sample
    else
      @quote = response.body
    end
  end

  def show
    @question = Question.where(id: params[:id]).first
  end

  def create
    @question = Question.new(question_params)
    if request.xhr?
      if @question.save
        render layout: false, partial: "question_from_ajax.html.erb", html: @question
        # data = render layout: false, partial: "question_display.html.erb", locals: {question: @question}
        # respond_to do |format|

      else
        status 406
        render :index
      end
    else
      if @question.save
        redirect_to root_path
      else
        status 406
        render :index
      end
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
