class Api::V1::BackgroundController < ApplicationController
  def index
    facade = BackgroundFacade.new(params[:location])
    render json: BackgroundImagesSerializer.new(facade.background_images)
  end
end
