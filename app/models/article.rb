class Article < ApplicationRecord
  include ImageUploader::Attachment(:image)

  validates :title, :body, presence: true

  belongs_to :user
end
