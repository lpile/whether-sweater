class BackgroundsFacade
  def initialize(photo_query)
    @image_id = flickr_service.find_image_id(photo_query)
  end

  def get_image
    image_info = flickr_service.get_image_info(@image_id)
    image_response(image_info)
  end

  private

  attr_reader :image_id

  def flickr_service
    @_flickr_service ||= FlickrService.new
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
