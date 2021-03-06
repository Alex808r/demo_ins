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
#
#
require 'ffaker'

FactoryBot.define do
  factory :user do
    email {FFaker::Internet.email }
    username {FFaker::Name.pronouns} # создаем имя при помощи FFaker
    #sequence(:email){|n| "user#{n}@test.com"} #создаем уникальные eмайлы в цикле
    #sequence(:username){|n| "User #{n}"}
    password {'123456'}
    password_confirmation {'123456'}
  end
end
