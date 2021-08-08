class ImageUploader < Shrine

  plugin :validation_helpers
  plugin :default_url


  Attacher.validate do
    validate_extension %w[jpg jpeg png gif webp]
  end


  Attacher.default_url do |**_options|
    "/placeholders/pixel.png"
  end
end