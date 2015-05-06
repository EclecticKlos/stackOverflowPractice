class AnswersController < ApplicationController
  def index
    @question = Question.where(id: params[:question_id]).first
    @answer = Answer.new
  end

  def create
    @question = Question.where(id: params[:question_id]).first
    if @question.answers.create!(answer_params)
      if request.xhr?
        p "$"*100
        render layout: false, partial: "answer_from_ajax.html.erb", html: @question.answers
      else
        redirect_to question_answers_path
      end
    else
      render :index
    end
  end

def answer_params
    params.require(:answer).permit(:title, :content)
  end
end
