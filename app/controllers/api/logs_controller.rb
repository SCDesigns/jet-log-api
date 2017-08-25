class Api::LogsController < ApplicationController

  def index
    @logs = Log.all
    render json: @logs
  end

  def show
    @log = Log.find_by(id: params[:id])
    render json: @log
  end

  def create
    @log = Log.new(log_params)
    if @log.save
      render json: @log
    else
      render json: { errors: { message: "This Log failed to save." }}
    end
  end

  def update
    @log = Log.find_by(id: params[:id])
    @log.update(log_params)
    if @log.save
      render json: @log
    else
      render json: { errors: { message: "This Log failed to update." }}
    end
  end

  private
    def log_params
      params.require(:log).permit(:title, :description, :location, :memory)
    end
end
