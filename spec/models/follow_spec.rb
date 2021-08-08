# == Schema Information
#
# Table name: follows
#
#  id           :integer          not null, primary key
#  follower_id  :integer
#  following_id :integer
#
# Foreign Keys
#
#  follower_id   (follower_id => users.id)
#  following_id  (following_id => users.id)
#
require 'rails_helper'

RSpec.describe Follow, type: :model do

  describe "associations" do
    it { should belong_to(:follower)  }
    it { should belong_to(:following) }
  end

end
