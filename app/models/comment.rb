class Comment < ApplicationRecord
  belongs_to :article

  validates :author, presence: true, length: {minimum: 2}
  validates :body,  presence: true, length: {minimum: 2}

end
