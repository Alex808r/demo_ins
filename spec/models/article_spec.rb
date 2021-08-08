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

end

