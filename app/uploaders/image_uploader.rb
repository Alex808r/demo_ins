class ImageUploader < Shrine

  plugin :validation_helpers

  Attacher.validate do
    validate_extension %w[jpg jpeg png gif]
  end
end