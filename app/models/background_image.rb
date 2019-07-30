class BackgroundImage
  attr_reader :id, :alt, :url

  def initialize(params)
    @id = 0
    @alt = params[:title]
    @url = "https://www.flickr.com/photos/#{params[:owner]}/#{params[:id]}"
  end
end
