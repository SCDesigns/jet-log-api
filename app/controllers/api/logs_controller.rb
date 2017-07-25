class Api::LogsController < ApplicationController
  def index
    @logs = Log.all
    render json: @logs
  end

  def create
    @log = Log.new(log_params)
    if @log.save
      render json: @log
    else
      render json: { errors: { message: "This Log failed to save." }}
    end
  end

  private
    def log_params
      params.require(:log).permit(:title, :description, :location)
    end
end
