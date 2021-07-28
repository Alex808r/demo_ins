class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User", foreign_key: "follower_id",   :dependent => :destroy
  belongs_to :following, class_name: "User", foreign_key: "following_id", :dependent => :destroy
end