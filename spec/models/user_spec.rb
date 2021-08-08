# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){build(:user)}

  it "should be valid" do
    #expect(user.valid?).to eq(true) аналогичная запись
    expect(user).to be_valid
  end

  describe "associations" do
    it { should have_many (:articles)   }
    it { should have_many (:followings) }
    it { should have_many (:followers)  }
  end

  describe "validations" do
    it { should validate_presence_of(:email)       }
    #it { should validate_uniqueness_of(:email)     }
    it { should validate_presence_of(:password)    }
    it { should validate_presence_of(:username)    }
    it { should validate_uniqueness_of(:username)  }
  end
end
