# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  body       :text
#  image_data :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Article < ApplicationRecord
  include ImageUploader::Attachment(:image) # подлючаем загрузку изображений

  validates :title, presence: true, length: {minimum: 2, maximum: 100} # валидация наличия и длины
  validates :body,  presence: true, length: {minimum: 2, maximum: 100} # валидация наличия и длины
  validates :image, presence: true


  belongs_to :user

  has_many :comments, dependent: :destroy, validate: true

  has_many :likes, dependent: :destroy
end
