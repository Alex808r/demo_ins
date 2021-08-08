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
FactoryBot.define do
  factory :comment do
    sequence(:author){ |n| "Author #{n}" }
    sequence(:body) { |n| "Comment #{n}"  }
    association(:article)
  end
end
