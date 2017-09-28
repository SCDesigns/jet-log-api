class Api::LogsController < ApplicationController
  before_action :load_log, only: [:show, :update, :destroy]

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
    if @log.update(log_params)
      render json: @log
    else
      render json: { errors: { message: "This Log failed to update." }}
    end
  end

  private

    def load_log
      @log = Log.find(params[:id])
    end

    def log_params
      params.require(:log).permit(:title, :description, :location, :latitude, :longitude, :memory, :likes)
    end
end
