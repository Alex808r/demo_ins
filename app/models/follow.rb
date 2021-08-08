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
class Follow < ApplicationRecord
  belongs_to :follower,  class_name: "User", foreign_key: "follower_id",  :dependent => :destroy
  belongs_to :following, class_name: "User", foreign_key: "following_id", :dependent => :destroy
end
