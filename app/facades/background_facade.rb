class BackgroundFacade

  def initialize(photo_query)
    @photo_query = photo_query
  end

  def background_images
    images.map do |image|
      BackgroundImage.new(image)
    end
  end

  private

  attr_reader :photo_query

  def flickr_service
    FlickrService.new(photo_query)
  end

  def images
    flickr_service.fetch_images[:photos][:photo]
  end
end
