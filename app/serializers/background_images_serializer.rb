class BackgroundImagesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :alt, :url
end
