class Api::V1::BackgroundsController < ApplicationController
  def index
    render json: BackgroundsFacade.new(params[:location]).get_image
  end
end
