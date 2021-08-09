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
require 'rails_helper'

RSpec.describe Article, type: :model do

  let(:article){build(:article)}

  #тест проверяет валидна ли фабрика
  it "should be valid" do
    #expect(article.valid?).to eq(true) аналогичная запись
    expect(article).to be_valid
  end

  describe "validations" do
    #it {is_expected.to validate_presence_of (:title)            } аналогичная запись
    it { should validate_presence_of(:title)              }
    it { should validate_presence_of(:body)               }
    #it {is_expected.to validate_length_of(:title).is_at_least(2)} аналогичная запись
    it { should validate_length_of(:title).is_at_least(2) }
    it { should validate_length_of(:title).is_at_most(20) }
    it { should validate_length_of(:body).is_at_least(2)  }
    it { should validate_length_of(:body).is_at_most(100) }
    it { should validate_presence_of(:image)              }
  end

  describe  "associations" do
    #it {is_expected.to belong_to(:user)} аналогичная запись
    it { should belong_to(:user)     }
    it { should have_many(:comments) }
    it { should have_many(:likes)    }
  end


  describe 'validates image format' do
    it 'allows to set PNG file as an image' do
      user = create(:user)
      subject.attributes = attributes_for(:article)
      subject.user = user
      is_expected.to be_valid
    end

    it 'does not allow to set TXT file as an image' do
      user = create(:user)
      subject.attributes = attributes_for(:article, :with_invalid_image)
      subject.user = user
      is_expected.to be_invalid
    end
  end
end

