class StatementsController < ApplicationController
  before_action :update_monitor, only: :index

  def index
    unless params[:study_mode].nil?
      @statements = Statement.where(study_mode: params[:study_mode],
                                    basis: params[:basis],
                                    educational_program: params[:educational_program])
                             .order('points DESC')
      else
        @statements = Statement.order('points DESC').limit(100)
    end
  end

  def update
    if Statement.all.empty? || Statement.minimum(:created_at) <= Time.now - 1.day
      User.delete_all
      Statement.delete_all
      Statement.get_statements
      render text: 'OK'
    else
      render text: 'FUCK YOU!'
    end
  end
end
