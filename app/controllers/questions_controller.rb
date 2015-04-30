class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def show
    @question = Question.where(id: params[:id]).first
  end

end
