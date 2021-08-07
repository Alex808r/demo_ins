class Article < ApplicationRecord
  include ImageUploader::Attachment(:image) # подлючаем загрузку изображений

  validates :title, presence: true, length: {minimum: 2} # валидация наличия и длины
  validates :body,  presence: true, length: {minimum: 2} # валидация наличия и длины
  #validates :image_data, presence: true


  belongs_to :user

  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
end
