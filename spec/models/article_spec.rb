require 'rails_helper'

RSpec.describe Article, type: :model do

  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
    it { should validate_length_of(:title).is_at_least(2) }
    it { should validate_length_of(:body).is_at_least(2) }
  end


  describe  "associations" do
    it { should belong_to(:user) }
    it { should have_many (:comments) }
    it { should have_many (:likes) }
  end
end
