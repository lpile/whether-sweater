class BackgroundsFacade
  def initialize(photo_query)
    @photo_query = photo_query
  end

  def get_image
    image_info = flickr_service.fetch_images
    image_response(image_info)
  end

  private

  attr_reader :photo_query

  def flickr_service
    @_flickr_service ||= FlickrService.new(photo_query)
  end


  def image_response(image_info)
    {
      data:
      {
        image_url: image_info
      }
    }
  end
end
