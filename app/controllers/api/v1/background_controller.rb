class Api::V1::BackgroundController < ApplicationController
  def index
    facade = BackgroundFacade.new(location_params[:location])
    render json: BackgroundImagesSerializer.new(facade.background_images)
  end

  private

  def location_params
    params.permit(:location)
  end
end
