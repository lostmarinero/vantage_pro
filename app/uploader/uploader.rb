class Uploader < CarrierWave::Uploader::Base
  storage :url

  def store_dir
    'images'
  end
end