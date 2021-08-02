class Article < ApplicationRecord
  include ImageUploader::Attachment(:image)

  validates :title, presence: true, length: {minimum: 2}
  validates :body,  presence: true, length: {minimum: 2}

  belongs_to :user

  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
end
