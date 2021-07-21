class Article < ApplicationRecord
  include ImageUploader::Attachment(:image)

  validates :title, :body, presence: true
end
