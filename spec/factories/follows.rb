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
FactoryBot.define do
  factory :follow do
    
  end
end
