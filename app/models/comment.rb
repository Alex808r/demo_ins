# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  author     :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :integer          not null
#  user_id    :integer
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#
# Foreign Keys
#
#  article_id  (article_id => articles.id)
#
class Comment < ApplicationRecord
  belongs_to :article

  validates :author, presence: true, length: {minimum: 2}
  validates :body,   presence: true, length: {minimum: 2}

end
