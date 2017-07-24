class Api::ContinentsController < ApplicationController
  def index
    @continents = Continent.all
    render json: @continents
  end
end
