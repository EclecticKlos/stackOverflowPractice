class QuestionsController < ApplicationController

  def index
    @questions = Question.all
    @question = Question.new
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

  def destroy
    q_to_destroy = Question.where(id: params[:id]).first
    q_to_destroy.destroy
    redirect_to root_path
  end

  def question_params
    params.require(:question).permit(:title, :content)
  end

end
