require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){build(:user)}

  it "user should be valid" do
    #expect(user.valid?).to eq(true) аналогичная запись
    expect(user).to be_valid
  end

  describe "user associations" do
    it { should have_many (:articles)   }
    it { should have_many (:followings) }
    it { should have_many (:followers)  }
  end

  describe "user validations" do
    it { should validate_presence_of(:email)       }
    it { should validate_presence_of(:password)    }
    it { should validate_presence_of(:username)    }
    it { should validate_uniqueness_of(:username)  }
  end
end
