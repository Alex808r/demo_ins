FactoryBot.define do
  factory :user do
    sequence(:email){|n| "user#{n}@test.com"}
    sequence(:username){|n| "User #{n}"}
    password {'123456'}
  end
end
