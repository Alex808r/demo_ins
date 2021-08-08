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
require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:comment){build(:comment)}

  #тест проверяет валидна ли фабрика
  it "should be valid" do
    #expect(comment.valid?).to eq(true) аналогичная запись
    expect(comment).to be_valid
  end

  describe "validations" do
    it { should validate_presence_of(:author)              }
    it { should validate_presence_of(:body)                }
    it { should validate_length_of(:author).is_at_least(2) }
    it { should validate_length_of(:body).is_at_least(2)   }
  end

  describe  "associations" do
    it { should belong_to(:article) }
  end


end
