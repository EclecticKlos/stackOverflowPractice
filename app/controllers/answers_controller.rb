class AnswersController < ApplicationController
  def index
    @question = Question.where(id: params[:question_id]).first
    @answer = Answer.new
  end

  def create
    question = Question.where(id: params[:question_id]).first
    if question.answers.create!(answer_params)
      redirect_to question_answers_path
    else
      status 406
      render :index
    end
  end

  def answer_params
    params.require(:answer).permit(:title, :content)
  end
end
