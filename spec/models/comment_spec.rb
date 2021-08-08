require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:comment){build(:comment)}

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
